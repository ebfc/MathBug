//
//  Clouds.m
//  Matching
//
//  Created by Emmy Chen on 7/19/11.
//  Copyright 2011 Kuaitech. All rights reserved.
//

#import "GameConfig.h"

@interface Clouds (PrivateMethod)

-(void)initClouds;
-(void) initCloud;
-(void) resetCloud;
-(void) resetClouds;

@end

@implementation Clouds

-(id) init {
    if((self = [super init])) {
        winSize = [CCDirector sharedDirector].winSize;
        [self initClouds];
        [self schedule:@selector(step:)];
    }
    return self;
}

-(void)initClouds {
	currentCloudTag = kCloudsStartTag;
	while(currentCloudTag < 212) {
		[self initCloud];
		currentCloudTag++;
	}
	
	[self resetClouds];
    
}
- (void)initCloud {	
	int cloudIndex = arc4random()%3+1;
	NSString *cloudFile = [NSString stringWithFormat:@"clouds%d.png", cloudIndex];
	
	CCSprite *cloud = [CCSprite spriteWithFile:cloudFile];
	if(![GameConfig game].isPhone) {
		cloud.scale = 2.0f;
	}
	[self addChild:cloud z:0 tag:currentCloudTag];
	cloud.opacity = 128;
}

- (void)resetClouds {
	
	currentCloudTag = kCloudsStartTag;
	
	while(currentCloudTag < 212) {
		[self resetCloud];
		
		CCSprite *cloud = (CCSprite*)[self getChildByTag:currentCloudTag];
		CGPoint pos = cloud.position;
		pos.y -= winSize.height/2;
        cloud.position = ccp(pos.x, pos.y);
		
		currentCloudTag++;
	}
}

- (void)resetCloud {
	
	CCSprite *cloud = (CCSprite*)[self getChildByTag:currentCloudTag];
	
	float distance = arc4random()%20 + 5;
	
	float scale = 5.0f / distance;
	cloud.scaleX = scale;
	cloud.scaleY = scale;
	if(random()%2==1) cloud.scaleX = -cloud.scaleX;
	
	CGSize size = cloud.contentSize;
	float scaled_width = size.width * scale;
	int randx = winSize.width + (int)scaled_width;
	int randy = winSize.height/2-(int)scaled_width;
	float x = arc4random()%randx - scaled_width/2;
	float y = arc4random()%randy + scaled_width/2 + winSize.height;
	cloud.position = ccp(x,y);
}

- (void)step:(ccTime)dt {
	
	
	for(int t=200; t < 212; t++) {
		CCSprite *cloud = (CCSprite*)[self getChildByTag:t];
		CGPoint pos = cloud.position;
		CGSize size = cloud.contentSize;
        if([GameConfig game].isPhone) 
            pos.x += 0.5f * cloud.scaleY;
        else 
            pos.x += 1.2 *cloud.scaleY;
		if(pos.x > winSize.width + size.width/2) {
			pos.x = -size.width/2;
		}
		cloud.position = pos;
	}
	
}
-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    [super dealloc];
}
@end
