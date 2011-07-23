//
//  GameOverDialog.m
//  Chain2
//
//  Created by Charles Magahern on 9/30/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "GameOverDialog.h"
#import "Chain2AppDelegate.h"

@implementation GameOverDialog
@synthesize score;
@synthesize opacity, color;
@synthesize delegate;

-(id) init {
	if ((self = [super init])) {
		NSString *bgFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"game-over-bg-hd.png" : @"game-over-bg.png");
		CCSprite *bgSprt = [CCSprite spriteWithFile:bgFile];
		[self addChild:bgSprt];
		
		_scoreLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", self.score] fontName:@"Verdana" fontSize:(32 * [Chain2AppDelegate screenScale])];
		[self addChild:_scoreLbl];
		
		NSString *playAgainFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"play-again-hd.png" : @"play-again.png");
		NSString *mainMenuFile  = ([Chain2AppDelegate screenScale] >= 2.0 ? @"main-menu-hd.png" : @"main-menu.png");
		CCMenuItemImage *playAgain = [CCMenuItemImage itemFromNormalImage:playAgainFile selectedImage:playAgainFile target:self selector:@selector(playAgain:)];
		CCMenuItemImage	*mainMenu  = [CCMenuItemImage itemFromNormalImage:mainMenuFile selectedImage:mainMenuFile target:self selector:@selector(mainMenu:)];
		
		CCMenu *menu = [CCMenu menuWithItems:playAgain, mainMenu, nil];
		[menu alignItemsHorizontallyWithPadding:5.0];
		menu.position = ccp(0.0, -[bgSprt boundingBox].size.height / 2 + (30.0 * [Chain2AppDelegate screenScale]));
		
		[self addChild:menu];
	}
	return self;
}
																																				   
-(void) setScore:(NSUInteger)s {
	score = s;
	[_scoreLbl setString:[NSString stringWithFormat:@"%d", s]];
}

-(void) setOpacity:(GLubyte)o {
	for (id child in [self children]) {
		if ([child conformsToProtocol:@protocol(CCRGBAProtocol)]) {
			CCNode<CCRGBAProtocol> *n = (CCNode<CCRGBAProtocol> *) child;
			[n setOpacity:o];
		}
	}
	opacity = o;
}

-(void) setColor:(ccColor3B)c {
	for (id child in [self children]) {
		if ([child conformsToProtocol:@protocol(CCRGBAProtocol)]) {
			CCNode<CCRGBAProtocol> *n = (CCNode<CCRGBAProtocol> *) child;
			[n setColor:c];
		}
	}
	
	color = c;
}

-(void) playAgain:(CCMenuItem *)sender {
	if ([self.delegate respondsToSelector:@selector(newGameButtonClicked)])
		[self.delegate newGameButtonClicked];
	if ([self.delegate respondsToSelector:@selector(gameOverMenuDismissed)])
		[self.delegate gameOverMenuDismissed];
}

-(void) mainMenu:(CCMenuItem *)sender {
	if ([self.delegate respondsToSelector:@selector(newGameButtonClicked)])
		[self.delegate mainMenuButtonClicked];
	if ([self.delegate respondsToSelector:@selector(gameOverMenuDismissed)])
		[self.delegate gameOverMenuDismissed];
}

-(void) remove {
	[self removeFromParentAndCleanup:YES];
}

@end
