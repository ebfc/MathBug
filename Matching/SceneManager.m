//
//  SceneManager.m
//  AbiTalk
//
//  Created by Emmy Chen on 3/5/11.
//  Copyright 2011 Kuaitech. All rights reserved.
//

#import "GameConfig.h"

#define TRANSITION_DURATION (1.2f)

@interface FadeWhiteTransition : CCTransitionFade
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipXLeftOver : CCTransitionZoomFlipX
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipYDownOver : CCTransitionFlipY
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface TransitionPageForward : CCTransitionPageTurn
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface TransitionPageBackward : CCTransitionPageTurn
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end


@implementation FadeWhiteTransition
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s withColor:ccWHITE];
}
@end

@implementation ZoomFlipXLeftOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationLeftOver];
}
@end

@implementation FlipYDownOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationDownOver];
}
@end

@implementation TransitionPageForward
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s backwards:NO];
}
@end

@implementation TransitionPageBackward
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s backwards:YES];
}
@end

static int sceneIdx=0;
static NSString *transitions[] = {
	@"TransitionPageForward",
	@"TransitionPageBackward",
	@"FlipYDownOver",
	@"FadeWhiteTransition",
	@"ZoomFlipXLeftOver",
	@"CCTransitionRadialCCW",
	@"CCTransitionRadialCW",
};

Class nextTransition()
{
	// HACK: else NSClassFromString will fail
	[CCTransitionRadialCCW node];
	
	sceneIdx++;
	sceneIdx = sceneIdx % ( sizeof(transitions) / sizeof(transitions[0]) );
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}




@interface SceneManager ()
+(void) go: (CCLayer *) layer;
+(CCScene *) wrap: (CCLayer *) layer;
@end

@implementation SceneManager

-(id)init {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	
	return self;
}



// go to menu scene
+(void) goMenu{
	CCLayer *layer = [Menu node];
	[SceneManager go: layer];
}

+(void) goMoreGames {
 MoreGameScene *layer = [MoreGameScene node];
 [SceneManager go:layer];
 }
 
+(void) goMathBug {
    
	CCLayer* layer = [MathBug node];
	[SceneManager go: layer];
}

/*
+(void) goPlay {
    Bonus33Scene *layer = [Bonus33Scene node];
    [SceneManager go:layer];
}
*/
+(void) go: (CCLayer *) layer{
	CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManager wrap:layer];
	
	Class transition = nextTransition();
	
	
	if ([director runningScene]) {
		[director replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:newScene]];
	}else {
		[director runWithScene:newScene];
	}
}

+(CCScene *) wrap: (CCLayer *) layer{
	CCScene *newScene = [CCScene node];
	[newScene addChild: layer];
	return newScene;
}


-(void)dealloc
{
	[super dealloc];
}
@end