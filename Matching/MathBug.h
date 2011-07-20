//
//  HelloWorldLayer.h
//  Matching
//
//  Created by Emmy Chen on 7/16/11.
//  Copyright Kuaitech 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define kAppleTag   0 
#define kChoicsTag  1

@interface MathBug : CCLayer
{
    CGSize winSize;
    int num1, num2, answer;
    int choics[3];
    int answerIndex;

    int currentQuestionIndex;
    
    int level;
    
    NSMutableArray *faceCount;
    NSMutableArray *birdSprites;
    CCSprite *bugSprite;
    CCSprite *appleSprite;
    
    NSMutableArray *flower1;
    NSMutableArray *flower2;
    int flower1Count, flower2Count;
    
    NSMutableArray *appleSprites;
}


+(CCScene *) scene;

@end
