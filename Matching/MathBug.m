//
//  HelloWorldLayer.m
//  Matching
//
//  Created by Emmy Chen on 7/16/11.
//  Copyright Kuaitech 2011. All rights reserved.
//


// Import the interfaces
#import "MathBug.h"
#import "SimpleAudioEngine.h"
#import "GameConfig.h"
#import "Clouds.h"

@interface MathBug (PrivateMethod)

-(void) initQuestion;
-(void) generateQuestion;
-(void) resetQuestion;

-(void) initFlowers;
-(void) addFlower2;
-(void) addFlower1;
-(void) cleanupFlowers;

@end


@implementation MathBug

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MathBug *layer = [MathBug node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) generateQuestion {
    /*
    switch (level) {
        //level1
        case 1:
            num1 = arc4random()%5;
            num2 = arc4random()%5;
            break;
            //level1
        case 2:
            num1 = arc4random()%5;
            num2 = arc4random()%5;
            break;

            //level1
        case 3:
            num1 = arc4random()%5;
            num2 = arc4random()%5;
            break;

            //level1
        case 4:
            num1 = arc4random()%5;
            num2 = arc4random()%5;
            break;

        default:
            break;
    }
*/
    num1 = arc4random()%4+1;
    num2 = arc4random()%4+1;

    answer = num1 + num2;
    answerIndex = arc4random()%3;
    choics[answerIndex] = answer;
    for(int i = 0; i < 3; i++) {
        if(i != answerIndex) {
            choics[i] = arc4random()%10;
            for(int j = 0; j < 3; j++) {
                if(i!=j && choics[i] == choics[j]) {
                    i--;
                    break;
                }
            }
        }
    }
}

-(void) addFlower2 {
    
    if(flower2Count < [flower2 count]) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
        CCSprite *sprite = [flower2 objectAtIndex:flower2Count];
        
        sprite.position = ccp(150+50*flower2Count, 350);
        [self addChild:sprite z:1 tag:1];
        
        flower2Count++;
    }
}
-(void) addFlower1 {
    
    if(flower1Count < [flower1 count]) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
        CCSprite *sprite = [flower1 objectAtIndex:flower1Count];
        sprite.position = ccp(150+50*flower1Count, 450);
        [self addChild:sprite z:1 tag:2];
        
        flower1Count++;
    } 
    
    if(flower1Count == [flower1 count]) {        
        for(int i = 0; i < [flower2 count]; i++) {
            [self performSelector:@selector(addFlower2) withObject:self afterDelay:(i+1)*0.2];   

        }
    }
}

-(void) initFlowers {
    if(num1 != 0) {
        for(int i = 0; i < num1; i++) {
            CCSprite *sprite = [CCSprite spriteWithFile:@"flower1.png"];
            [flower1 addObject:sprite];
        }
        flower1Count = 0;
        for(int i = 0; i < [flower1 count]; i++) {
            [self performSelector:@selector(addFlower1) withObject:self afterDelay:(i+1)*0.2];   
        }
    }
    
    flower2Count = 0;
    if(num2 !=0) {
        for(int i = 0; i < num2; i++) {
            CCSprite *sprite = [CCSprite spriteWithFile:@"flower2.png"];
            [flower2 addObject:sprite];
        }
    }
}

-(void) cleanupFlowers {
    for(CCSprite *sprite in flower1) {
        [self removeChild:sprite cleanup:YES];
    }

    for(CCSprite *sprite in flower2) {
        [self removeChild:sprite cleanup:YES];
    }

    [flower1 removeAllObjects];
    [flower2 removeAllObjects];
    
    
    [flower1 release];
    flower1 = nil;
    flower1 = [[[NSMutableArray alloc] initWithCapacity:5] retain];
    
    [flower2 release];
    flower2  = nil;
    flower2   = [[[NSMutableArray alloc] initWithCapacity:5] retain];
    
    flower1Count = 0; 
    flower2Count = 0;
   // [self initFlowers];

}

-(void) initQuestion {
    [self generateQuestion];
    for(int i = 0; i < 3; i++) {
        CCSprite *sprite = (CCSprite*) [ birdSprites objectAtIndex:i];
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", choics[i]] fontName:@"Arial" fontSize:40];
        label.position = ccp(sprite.contentSize.width/2, sprite.contentSize.height*1/3);
        [sprite addChild:label z:1 tag:kChoicsTag];
        
        if(i == answerIndex)         {
            CCLabelTTF *a = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", choics[i]] fontName:@"Arial" fontSize:60];
            a.position = ccp(appleSprite.contentSize.width/2, appleSprite.contentSize.height*1/3);
            a.color = ccYELLOW;
            [appleSprite addChild:a];
        }
    }
    
    CCLabelTTF *plusSign = [CCLabelTTF labelWithString:@"+" fontName:@"Arial" fontSize:50];
    plusSign.position = ccp(bugSprite.contentSize.width/2, bugSprite.contentSize.height*1/3);
    
    CCLabelTTF *num1Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", num1] fontName:@"Arial" fontSize:50];
    plusSign.position = ccp(bugSprite.contentSize.width/2, bugSprite.contentSize.height*1/3);

    CCLabelTTF *num2Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", num2] fontName:@"Arial" fontSize:50];
    
    plusSign.color = ccYELLOW;
    num1Label.color = ccYELLOW;
    num2Label.color = ccYELLOW;
    plusSign.position = ccp(bugSprite.contentSize.width*1/3, bugSprite.contentSize.height*2/5);
    num1Label.position = ccp(bugSprite.contentSize.width*0.16, bugSprite.contentSize.height*2/5);
    num2Label.position = ccp(bugSprite.contentSize.width*0.45, bugSprite.contentSize.height*2/5);

    
    
    [bugSprite addChild:plusSign];
    [bugSprite addChild:num1Label];
    [bugSprite addChild:num2Label];
    
    
}


-(void) resetQuestion {
    [self generateQuestion];
    
    [bugSprite removeAllChildrenWithCleanup:YES];
    [appleSprite removeAllChildrenWithCleanup:YES];

    for(int i = 0; i < 3; i ++) {
        CCSprite *sprite = [birdSprites objectAtIndex:i];
        //[sprite removeAllChildrenWithCleanup:YES];
        [sprite removeChildByTag:kChoicsTag cleanup:YES];
        CCSprite *apple = (CCSprite*) [sprite getChildByTag:kAppleTag];
        apple.visible = YES;
    }
    [self initQuestion];
}

-(void) initfaceCount {
    for(int i = 0; i < 10; i++) {
        CCSprite *sprite = [CCSprite spriteWithFile:@"face-md.png"];
        [faceCount addObject:sprite];
        sprite.position = ccp(winSize.width*1/3+50*i, winSize.height-sprite.contentSize.height/2);
        [sprite setOpacity:128];
        sprite.color = ccWHITE;
        [self addChild:sprite];
    }
}

-(void) updateFace {
    for(int i = 0; i < currentQuestionIndex; i++) {
        CCSprite *sprite = [faceCount objectAtIndex:i];
        sprite.color = ccGREEN;
        [sprite setOpacity:255];
    }
}

-(void) resetFace {
    for(int i = 0; i < 10; i++) {
        CCSprite *sprite = [faceCount objectAtIndex:i];
        sprite.color = ccWHITE;
        [sprite setOpacity:128];
    }

}

-(void) bugMovein {
    [[SimpleAudioEngine sharedEngine] playEffect:@"bugIn.mp3"];
    [bugSprite setPosition:ccp(-bugSprite.contentSize.width, bugSprite.contentSize.height/4)];
	[bugSprite runAction: [CCSequence actions: 
                           [CCEaseExponentialOut actionWithAction: 
                         [CCMoveTo actionWithDuration:3 position:ccp(512, bugSprite.contentSize.height/4)]],
                         //[CCCallFuncN actionWithTarget:self selector:@selector(bugMe1:)],
                         nil]];

}

-(void) bugMoveout {
    [[SimpleAudioEngine sharedEngine] playEffect:@"bugOut.mp3"];

    [bugSprite runAction: [CCSequence actions: 
                           [CCEaseSineOut actionWithAction: 
                            [CCMoveTo actionWithDuration:3 position:ccp(winSize.width+bugSprite.contentSize.width, bugSprite.contentSize.height/4)]],
                           //[CCCallFuncN actionWithTarget:self selector:@selector(bugMe1:)],
                           nil]];

    [appleSprite runAction:[CCSequence actions: 
                            [CCEaseSineOut actionWithAction: 
                             [CCMoveTo actionWithDuration:3 position:ccp(winSize.width+bugSprite.contentSize.width, bugSprite.contentSize.height/4)]],
                            //[CCCallFuncN actionWithTarget:self selector:@selector(bugMe1:)],
                            nil]];

}

-(void) reset {
    [self resetQuestion];
    [self cleanupFlowers];
    [self performSelector:@selector(bugMovein) withObject:nil afterDelay:3];
    [self performSelector:@selector(initFlowers) withObject:nil afterDelay:4];
    [appleSprite setPosition:ccp(0,0)];
}
// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
		winSize = [CCDirector sharedDirector].winSize;
        // add background
        
        CCSprite *bg = [CCSprite spriteWithFile:@"background.png"];
        bg.scale = 1.7;
        bg.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:bg z:-3];
        
        CCSprite *clouds = [Clouds node];
        [self addChild:clouds z:-2];
        /*
        // add tree
        CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
        tree.scaleY = 1.3;
        tree.position = ccp(winSize.width-tree.contentSize.width/2, winSize.height/2-tree.contentSize.height/3);
        [self addChild:tree z:-2];
        */
        
        // apple answer
        appleSprite = [CCSprite spriteWithFile:@"apple.png"];
        appleSprite.visible = NO;
        [self addChild:appleSprite z:1];
        
        
        currentQuestionIndex = 0;
        faceCount = [[[NSMutableArray alloc] init] retain];
        flower1 = [[[NSMutableArray alloc] init] retain];
        flower2 = [[[NSMutableArray alloc]init]retain];
        // create bug for question
        bugSprite = [[CCSprite spriteWithFile:@"bug.png"] retain];
        //bugSprite.position = ccp(512, bugSprite.contentSize.height/4);
        [self addChild:bugSprite];
        [self bugMovein];

        birdSprites = [[[NSMutableArray alloc] init] retain];
        //appleSprites = [[[NSMutableArray alloc] init] retain];
        
        int moveDistance[3] = {-20, 30, -20};
        
        for(int i = 0; i < 3; i++) {
            
            CCSprite *sprite = [CCSprite spriteWithFile:@"bird.png"];
            CCSprite *apple = [CCSprite spriteWithFile:@"apple-small.png"];
            sprite.position = ccp(400+150*i, winSize.height*4/5);
            apple.position = ccp(sprite.contentSize.width/2, apple.contentSize.height/2);
            [sprite addChild:apple z:0 tag:kAppleTag];
            [birdSprites addObject:sprite];
            
            [sprite runAction:[CCRepeatForever actionWithAction:[CCSequence actions: 
                                                                 [CCEaseSineOut actionWithAction:
                                                                 [CCMoveBy actionWithDuration:1 position:ccp(0, moveDistance[i])]],
                                                                 [CCEaseSineOut actionWithAction:
                                                                 [CCMoveBy actionWithDuration:1 position:ccp(0, -moveDistance[i])]], 
                                                                 nil]]];
            [self addChild:sprite];
        }
        
        [self initfaceCount];
        [self initQuestion];
        [self initFlowers];

        self.isTouchEnabled = YES;
        
        // add particle system.
        CCParticleSystem *system;
        if([GameConfig game].isPhone) 
             system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"flowerParticleIphone.plist"];
        else 
            system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"flowerParticle.plist"];
        [self addChild:system z:-1];
        
	}
	return self;
}


-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) addAppleAnswer {

    [[SimpleAudioEngine sharedEngine] playEffect:@"cheering.mp3"];
    CCSprite *answerBird = [birdSprites objectAtIndex:answerIndex];
    [appleSprite setPosition:answerBird.position];
    appleSprite.scale = 0.2;
    /*
    ccBezierConfig bezier;
	bezier.controlPoint_1 = ccp([GameConfig convertX:350], winSize.height-[GameConfig convertY:100]);
    bezier.controlPoint_2 = ccp([GameConfig convertX:250],winSize.height);
	bezier.endPosition = ccp(winSize.width-[GameConfig convertX:50], [GameConfig convertY:40]);
	
    id bezierAct = [CCBezierBy actionWithDuration:2 bezier:bezier];

    [appleSprite runAction:bezierAct];
     */
    id action = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(winSize.width-[GameConfig convertX:50], [GameConfig convertY:40])] rate:2];
    id scale = [CCScaleTo actionWithDuration:1  scale:1];
    [appleSprite runAction:[CCSpawn actions:action, scale, nil]];
    appleSprite.visible = YES;
}


-(BOOL) ccTouchBegan:(UITouch *) touch withEvent:(UIEvent*) event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    for(int i = 0; i < 3; i++) {
        CCSprite* sprite = (CCSprite*)[birdSprites objectAtIndex:i];
        if(CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            if(i == answerIndex) { // click the correct answer
                
                currentQuestionIndex++;
               // move up one level
                
                if(currentQuestionIndex>=10) { 
                    currentQuestionIndex= 0;
                    [self resetFace ];
                
                } else {    //reset everything
                    [self updateFace];
                }
                CCSprite *apple = (CCSprite*)[sprite getChildByTag:kAppleTag];
                apple.visible = NO;
                
                [self addAppleAnswer];
                
                [self performSelector:@selector(bugMoveout) withObject:nil afterDelay:4];
                [self performSelector:@selector(reset) withObject:nil afterDelay:5];
            } else {
                
                // add particle
                CCParticleSystem *system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"right.plist"];
                system.position = sprite.position;
                system.autoRemoveOnFinish = YES;
                system.blendAdditive = NO;
                [self addChild:system z:1];
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"bubble.mp3"];

            }
        }
    }
    
	return YES;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [faceCount removeAllObjects];
    [faceCount release];
    faceCount = nil;
    
    [bugSprite release];
    bugSprite = nil;
    
    [birdSprites removeAllObjects];
    [birdSprites release];
    birdSprites = nil;
    
    [flower1 removeAllObjects];
    [flower1 release];
    flower1 = nil;
    
    [flower2 removeAllObjects];
    [flower2 release];
    flower2= nil;
    
    [appleSprite release];
    appleSprite = nil;
    
	[super dealloc];
}
@end
