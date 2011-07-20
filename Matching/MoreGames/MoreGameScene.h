
//  Created by Tim Sills on 2/26/10.
//

#import "cocos2d.h"
#import "LoopingMenu.h"
#import "InputController.h"

// MenuScene Layer
@interface MoreGameScene : CCLayer
{
	CCSprite *menuSprite;
	CGSize winSize;
	CCLabelTTF *menuSelection;
	int index;
	int iconScale;
}



@end
