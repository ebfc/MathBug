//
//  Clouds.h
//  Matching
//
//  Created by Emmy Chen on 7/19/11.
//  Copyright 2011 Kuaitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


#define kNumClouds 12
#define kCloudsStartTag 200;

@interface Clouds : CCSprite  {
    int currentCloudTag;
    CGSize winSize;
}

@end
