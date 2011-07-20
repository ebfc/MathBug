//
//  Menu.m
//  Matching
//
//  Created by Emmy Chen on 7/19/11.
//  Copyright 2011 Kuaitech. All rights reserved.
//

#import "GameConfig.h"


@implementation Menu

-(id) init {
    if((self = [super init])) {
        winSize = [CCDirector sharedDirector].winSize;
        
        // info more games, setup
        CCLabelTTF *addLabel = [CCLabelTTF labelWithString:@"Addition +" fontName:@"Arial" fontSize:60];
        addLabel.color = ccBLUE;
        addLabel.position = ccp([GameConfig convertX:50], winSize.height - [GameConfig convertY:80]);
        [self addChild:addLabel];
        for(int i = 10; i < 15; i++) {
            CCMenuItem *menu = [CCMenuItemImage itemFromNormalImage:@"star1.png" 
                                                   selectedImage:@"star1.png"
                                                          target:self
                                                        selector:@selector(goGame:)];
            menu.tag = i;
            menu.position = ccp([GameConfig convertX:(50+50*(i-10))], winSize.height - [GameConfig convertY:120]);
        }
        
        // info more games, setup
        CCLabelTTF *subLabel = [CCLabelTTF labelWithString:@"Subtraction -" fontName:@"Arial" fontSize:60];
        subLabel.color = ccBLUE;
        subLabel.position = ccp([GameConfig convertX:50], winSize.height - [GameConfig convertY:180]);
        [self addChild:addLabel];
        for(int i = 20; i < 25; i++) {
            CCMenuItem *menu = [CCMenuItemImage itemFromNormalImage:@"star2.png" 
                                                      selectedImage:@"star2.png"
                                                             target:self
                                                           selector:@selector(goGame:)];
            menu.tag = i;
            menu.position = ccp([GameConfig convertX:(50+50*(i-20))], winSize.height - [GameConfig convertY:220]);
        }

    }
    return self;
}


-(void) dealloc {
    [super dealloc];
}
@end
