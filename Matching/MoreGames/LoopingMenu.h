/*
 *  LoopingMenu.h
 *  Banzai
 *
 *  Created by João Caxaria on 5/29/09.
 *  Copyright 2009 Imaginary Factory. All rights reserved.
 *
 */
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface LoopingMenu : CCMenu
{	
	float hPadding;
	bool moving;
	bool touchDown;
	float maximumEffectiveDistance;
	float terminalDistance;
}

/*The maximum distance where scaling stops.  The closer this is to zero, the 
 larger the minimum size and opacity of the object.*/
@property (readwrite, assign, nonatomic) float maximumEffectiveDistance;
/*The distance from the center when an item should size zero.*/
@property (readwrite, assign, nonatomic) float terminalDistance;
@end
