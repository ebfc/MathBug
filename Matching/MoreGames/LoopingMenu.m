#import "LoopingMenu.h"
#import "InputController.h"
#import "GameConfig.h"
@interface CCMenu (Private)
// returns touched menu item, if any, implemented in Menu.m
-(CCMenuItem *) itemForTouch: (UITouch *) touch;



@end

@interface LoopingMenu (Animation)

-(void) updateAnimation;
-(void) moveItemsLeftBy:(float) offset;
-(void) moveItemsRightBy:(float) offset;

@end

@implementation LoopingMenu

@synthesize maximumEffectiveDistance, terminalDistance;

#pragma mark -
#pragma mark Menu

- (id) initWithItems: (CCMenuItem*) item vaList: (va_list) args
{
	if ((self = [super initWithItems:item vaList:args]))
	{
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		maximumEffectiveDistance = winSize.width/2;
		terminalDistance = maximumEffectiveDistance * 1.25;
	}
	return self;
}

-(void) alignItemsVerticallyWithPadding:(float)padding
{
	[self alignItemsHorizontallyWithPadding:padding];
}

-(void) alignItemsHorizontallyWithPadding:(float)padding
{
	hPadding = padding;
	[super alignItemsHorizontallyWithPadding:padding];
	[self updateAnimation];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:false];
}

#pragma mark -
#pragma mark Touches

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if([[event allTouches] count] != 1)
		return false;
	
	touchDown = true;
	moving = false;
	selectedItem_ = [super itemForTouch:touch];
	[selectedItem_ selected];
	
	state_ = kCCMenuStateTrackingTouch;
	return true;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if([[event allTouches] count] != 1)
	{
		[self ccTouchCancelled:touch withEvent:event];
		return;
	}
	
	if(!moving && state_ == kCCMenuStateTrackingTouch)
		[super ccTouchEnded:touch withEvent:event];
	else if(state_ == kCCMenuStateTrackingTouch)
	{
		//  We were scrolling so calcuate a velocity.
		[self ccTouchCancelled:touch withEvent:event];
	}
	
	
	moving = false;
	touchDown = false;
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[selectedItem_ unselected];
	
	touchDown = false;
	state_ = kCCMenuStateWaiting;
	
	moving = false;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if([[event allTouches] count] != 1)
	{
		[self ccTouchCancelled:touch withEvent:event];
		return;
	}
	NSMutableSet* touches = [[[NSMutableSet alloc] initWithObjects:touch, nil] autorelease];
	
	CGPoint distance = icDistance(1, touches, event);
	
	if(icWasSwipeLeft(touches, event) && distance.y < distance.x)
	{
		moving = true;
		[self moveItemsLeftBy:-distance.x];
	} 
	else if(icWasSwipeRight(touches, event)  && distance.y < distance.x)
	{
		moving = true;
		[self moveItemsRightBy:distance.x];
	}
	else if(!moving && state_ == kCCMenuStateTrackingTouch)
	{
		[super ccTouchMoved:touch withEvent:event];
	}
	
}


@end

@implementation LoopingMenu (Animation)

-(void) moveItemsLeftBy:(float) offset
{
	//  This method is similar in form to moveItemsRightBy:.
	//  Check that function for the explanation of the functionality.
	[selectedItem_ unselected];
	
	for(CCMenuItem<CCRGBAProtocol>* item in children_)
	{
		[item setPosition:ccpAdd([item position], ccp(offset, 0))];
	}
	
	CCMenuItem* leftItem = [children_ objectAtIndex:0];
	if(leftItem.position.x + leftItem.contentSize.width / 2.0  < -maximumEffectiveDistance)
	{
		[leftItem retain];
		[children_ removeObjectAtIndex:0];
		CCMenuItem* lastItem = [children_ objectAtIndex:[children_ count] - 1];
		float xOffset = ((lastItem.contentSize.width + leftItem.contentSize.width)/2.0)
		+ hPadding;
		[leftItem setPosition:ccpAdd([lastItem position], ccp(xOffset, 0))];
		[children_ addObject:leftItem];
		[leftItem autorelease];
	}
	[self updateAnimation];
}

-(void) moveItemsRightBy:(float) offset
{
	//  Deselect the currently selected item.
	[selectedItem_ unselected];
	
	//  Move all the items by the specified offset.
	for(CCMenuItem<CCRGBAProtocol>* item in children_)
	{
		[item setPosition:ccpAdd([item position], ccp(offset, 0))];
	}
	
	//  Get the last item in the menu.  This is the currently the right most object.
	CCMenuItem* lastItem = [children_ objectAtIndex:[children_ count] - 1];
	
	CGPoint lastItemPos = lastItem.position;
	CGSize lastItemSize = lastItem.contentSize;
	
	//  If the last item
	if(lastItemPos.x - (lastItemSize.width / 2.0) > maximumEffectiveDistance)
	{
		//  Retain the object before removing it from our list of children.
		[lastItem retain];
		[children_ removeObjectAtIndex:[children_ count] - 1];
		
		//  Get the first item, the left most one.
		CCMenuItem* firstItem = [children_ objectAtIndex:0];
		
		CGPoint firstItemPos = firstItem.position;
		CGSize firstItemSize = firstItem.contentSize;
		
		//  Position the last item to the left of the current first item.
		//  Combine the width of first object, the former last object and the padding
		//  then subtract that from the first item's positon to use as the last 
		//  item's new position.
		float xOffset = ((firstItemSize.width + lastItemSize.width) / 2.0) + hPadding;
		lastItem.position = ccpSub(firstItemPos, ccp(xOffset, 0));
		
		//  Add the last item to the front of our list of children, making it
		//  the new first item.  Then release our reference.
		[children_ insertObject:lastItem atIndex:0];
		[lastItem autorelease];
	}
	[self updateAnimation];
}


-(void) updateAnimation
{
	float quadraticCoefficient = -1.0/(terminalDistance*terminalDistance);
	
	for(CCMenuItem<CCRGBAProtocol>* item in children_)
	{
		
		CGPoint itemPosition = item.position;
				
		float distance = fabsf(itemPosition.x);
		
		//  Clamp the distance to the maximum effective distance.
		if(distance > maximumEffectiveDistance)
			distance = maximumEffectiveDistance;
		
		//  The closer the distance approaches the terminalDistance,
		//  the lower the ratio.
		float distanceSquared = distance*distance;
		float r = 1;
		if([GameConfig game].isPhone) {
			r =0.75;
            //r = 1;
		}
		float ratio = quadraticCoefficient * distanceSquared + r;
		
		[item setScale: ratio];
	}
}


@end