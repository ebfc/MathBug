//
//  GameConfig.m
//  Phonics Game
//
//  Created by Emmy Chen on 7/6/11.
//  Copyright 2011 Kuaitech. All rights reserved.
//


#import "GameConfig.h"


@implementation GameConfig
@synthesize isPhone;
@synthesize level;
@synthesize type;
static GameConfig* singleton = nil; 

+(GameConfig*) game {
	@synchronized(self) {
		if(!singleton) {
			singleton = [[[self class] alloc] init];
		}
	}
    
	return singleton;	
}

-(id) init {
	self = [super init];
	
	if(!self) {
		return nil;
	}
	
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        isPhone = YES;
    } else isPhone = NO;
 
    return self;
}


+ (CGPoint)convertPoint:(CGPoint)point {    
    if(![GameConfig game].isPhone) {
        CGPoint p =  {18 + point.x*2,  point.y*2};
        return p;
    } else {
        return point;
    }    
}


+(int) convertX: (int) xpos {
    if(![GameConfig game].isPhone) {
        return (18 + xpos*2);
    } else {
        return xpos;
    }    
}

+(int) convertY:(int) ypos {
    if(![GameConfig game].isPhone) {
        return (ypos*2);
    } else {
        return ypos;
    }    	
	
}


@end
