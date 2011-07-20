//  Created by Tim Sills on 2/26/10.
//


// Import the interfaces

#import "LoopingMenu.h"
#import "GameConfig.h"
ALuint soundID;
static const NSString* gamesIcon[] = {
	@"FunRhyming.png", @"FunRhymingPlus.png", @"PhonicsShortVowel.png", @"PhonicsLongVowel.png",  @"AlphabetMatching.png", @"AlphabetSong.png",
    @"AlphabetColoring.png", @"AlphabetFirstWords.png", @"AlphabetPlus.png", @"ThreeLetter.png", @"FourLetter.png",
};

static const NSString* gamesName[] = { 
	@"Fun Rhyming \n Kids learn to recognize word patterns by matching pairs of rhyming words.	The words appear on animated fruit.  Kids are motivated to pair the rhyming words to earn points toward a fun bonus game.  This game has more than 90 simple words for beginning readers.", 
	@"Fun Rhyming Plus \n Kids learn to recognize word patterns by matching pairs of rhyming words. The words appear on animated vegetables.  Kids are motivated to pair the rhyming words to earn points toward a fun bonus game.  This game has more than 90 words for readers that have already mastered the simplest words.", 
	@"Phonics Short Vowel \n Kids learn the short vowel sounds, by playing a game with animated fish swimming through an endless scrolling ocean background.  Kids are motivated to learn to recognize the words so they can earn fun bonus games.  This game teaches kids to recognize 130 words with short vowel sounds.", 
	@"Phonics Long Vowel \n Kids learn the long vowel sounds, by targeting animated planets, displayed against a starry sky.  Kids are motivated to learn so they can earn tickets and diamonds, and play fun bonus games.  This game teaches kids to recognize 149 words with long vowel sounds", 
    @"Alphabet Matching\n A fun game for young children to learn the alphabet by matching capital letters with lower case letters. Children can learn to recognize the letters by name, or by phonic sound to help in forming words.  ",
    @"Alphabet Song\n Abatalk Alphabet is a fun activity for children learning the alphabet. They will learn the alphabet song, and have fun placing the dancing letters in order.  They will learn the name of each letter, and also learn the phonics sound that the letter makes when forming words.",
    @"Alphabet Coloring\n ABC Coloring is a fun activity for children learning the alphabet. They will learn the alphabet song, and have fun coloring the 26 pictures while learning to recognize capital letters and lowercase letters.",
    @"Alphabet First Words\n Alphabet ABC is a fun activity for children learning the alphabet. They will learn the alphabet song, while they watch the letters dance. Each image is clickable, and they can learn the phonics sound each letter makes, and see animated examples.",
    @"Alphabet Plus\n ABC Alphabet Phonics Plus provides everything your child needs to learn the alphabet, phonics and the sound and first words associated with each letter. This app includes the Alphabet Song, a coloring book with a page for each letter, activities for learning the letters in sequence, and fun animated games to teach pronunciation and letter recognition.",
    
    @"Three Letter Spelling\nThe children will learn to assemble letters into words, while listening to the name and phonics sound of each letter. For each word, they are given a picture and three letters. They have to put the letters in the right order, while listening to the name and sound of the letter. ",
    @"Four Letter Spelling\nThe children will learn to assemble letters into words, while listening to the name and phonics sound of each letter. For each word, they are given a picture and four letters. They have to put the letters in the right order, while listening to the name and sound of the letter. ",
};


static const NSString* appLink[] ={ 
	@"http://itunes.apple.com/us/app/abatalk-phonics-rhyming/id437352931?mt=8",
	@"http://itunes.apple.com/us/app/abatalk-phonics-funrhyming/id438520700?mt=8",
	@"http://itunes.apple.com/us/app/abatalk-phonics-short-vowels/id441703185?mt=8",
	@"http://itunes.apple.com/us/app/abatalk-phonics-long-vowels/id443078666?mt=8",
    @"http://itunes.apple.com/us/app/abatalk-alphabet-phonics-matching/id445765770?mt=8",
    @"http://itunes.apple.com/us/app/abatalk-alphabet/id446659652?mt=8",
    @"http://itunes.apple.com/us/app/abc-alphabet-phonics-coloring/id447989618",
    @"http://itunes.apple.com/us/app/abc-alphabet-first-words-phonics/id447307741?mt=8",
    @"http://itunes.apple.com/us/app/abc-alphabet-plus/id448550793",
    @"http://itunes.apple.com/us/app/threeletterwords/id450153039",
    @"http://itunes.apple.com/us/app/fourletterwords/id450993324",
};


// MenuScene implementation
@implementation MoreGameScene

-(void) addIcon {
	menuSprite = [CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[index]];
	if([GameConfig game].isPhone) {
        menuSprite.scale = 0.6f;
		menuSprite.position = ccp(70, 100 );
	}else {
		menuSprite.position = ccp(winSize.width/2, 130);
	}
    [self addChild:menuSprite];
}

// on "init" you need to initialize your instance
-(id) init
{

	if( (self=[super init] )) {
		winSize = [CCDirector sharedDirector].winSize;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"otherGamesIcons.plist"];
        [[CCTextureCache sharedTextureCache] addImage:@"otherGamesIcons.pvr.ccz"];
        
		int ftSize = 24;
		int yOffset = 150;
		iconScale = 1.5;
		if([GameConfig game].isPhone) {
			ftSize = 14;
			yOffset = 80;
			iconScale = 0.8;
		}
		menuSelection = [CCLabelTTF labelWithString:(NSString*)gamesName[0] 
										 dimensions:CGSizeMake(winSize.width/2+30,250)
										  alignment:CCTextAlignmentCenter
									  lineBreakMode:CCLineBreakModeWordWrap fontName:@"Arial" fontSize:ftSize];
		
		
		if([GameConfig game].isPhone) {
			menuSelection.position = ccp(280, 50);
		} else {
			menuSelection.position = ccp(winSize.width/2,winSize.height/2-30);
		}
		[self addChild:menuSelection];
		
		
			
		CCMenuItem *item1 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[0]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[0]] target:self selector:@selector(MenuItem1:)];
		
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[1]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[1]] target:self selector: @selector(MenuItem2:)];
        
        CCMenuItem *item3 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[2]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[2]] target: self selector: @selector(MenuItem3:)];
        
        CCMenuItem *item4 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[3]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[3]] target: self selector: @selector(MenuItem4:)];
        
        CCMenuItem *item5 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[4]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[4]] target: self selector: @selector(MenuItem5:)];
        
        CCMenuItem *item6 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[5]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[5]] target: self selector: @selector(MenuItem6:)];
        
        CCMenuItem *item7 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[6]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[6]] target: self selector: @selector(MenuItem7:)];
        
        CCMenuItem *item8 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[7]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[7]] target: self selector: @selector(MenuItem8:)];
        
        CCMenuItem *item9 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[8]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[8]] target: self selector: @selector(MenuItem9:)];
        
        
        CCMenuItem *item10 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[9]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[9]] target: self selector: @selector(MenuItem10:)];
        
        CCMenuItem *item11 = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[10]]
                                                   selectedSprite:[CCSprite spriteWithSpriteFrameName:(NSString*)gamesIcon[10]] target: self selector: @selector(MenuItem11:)];

		LoopingMenu *menu = [LoopingMenu menuWithItems:item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, nil];
		menu.position = ccp(winSize.width/2, winSize.height-yOffset);
		[menu alignItemsHorizontallyWithPadding:[GameConfig convertX:5]];
		[self addChild:menu];
		

		index = 0;
		[self addIcon];
		self.isTouchEnabled = YES;
	
	
		CCMenuItem *home = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithFile:@"homeBtn.png"]
                                                  selectedSprite:[CCSprite spriteWithFile:@"homeBtn.png"]
                                                          target: self selector: @selector(goHome)];
		CCMenu *menuHome = [CCMenu menuWithItems:home,nil];
		menuHome.position = ccp(winSize.width - [GameConfig convertX:25], [GameConfig convertY:25]);
		[self addChild:menuHome];

        if([GameConfig game].isPhone)    {
            home.scale = 0.65;
        }
	}
	return self;
}


-(void) goHome {
    [[SimpleAudioEngine sharedEngine] stopEffect:soundID];
	soundID = [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];

    [SceneManager goMenu];
    
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// don't forget to call "super dealloc"
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

	[super dealloc];
}

-(void) gotoStore {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:(NSString*)appLink[index]]];
}

-(void)MenuItem1:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[0]];
	index = 0;
	[self addIcon];
}

-(void)MenuItem2:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[1]];
	index = 1;
	[self addIcon];

}

-(void)MenuItem3:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[2]];
	index = 2;
	[self addIcon];

}

-(void)MenuItem4:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[3]];
	index = 3;
	[self addIcon];

}

-(void)MenuItem5:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];

	[menuSelection setString:(NSString*) gamesName[4]];
	index = 4;
	[self addIcon];

}


-(void)MenuItem6:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[5]];
	index = 5;
	[self addIcon];

}

-(void)MenuItem7:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[6]];
	index = 6;
	[self addIcon];
    
}

-(void)MenuItem8:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[7]];
	index = 7;
	[self addIcon];
    
}

-(void)MenuItem9:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[8]];
	index = 8;
	[self addIcon];
    
}

-(void)MenuItem10:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[9]];
	index = 9;
	[self addIcon];
    
}


-(void)MenuItem11:(id)sender {
	
	[self removeChild:menuSprite cleanup:YES];
	[menuSelection setString:(NSString*)gamesName[10]];
	index = 10;
	[self addIcon];
    
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
                                                     priority:0 
                                              swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
	BOOL selected = NO;
	CGPoint pt = [self convertTouchToNodeSpace:touch];
	if(CGRectContainsPoint([menuSprite boundingBox], pt)) {
		[self gotoStore];
		selected = YES;
	}
	return selected;
}

@end
