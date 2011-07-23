//
//  TitleScene.m
//  Chain2
//
//  Created by Charles Magahern on 9/26/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"
#import "Explosion.h"

#import "Chain2AppDelegate.h"

@implementation TitleScene

+(id) scene {
	TitleScene *scene = [TitleScene node];
	
	CGSize screenSize = [[CCDirector sharedDirector] displaySize];
	
	NSString *bgFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"title-bg-hd.png" : @"title-bg.png");
	CCSprite *bgSprite = [CCSprite spriteWithFile:bgFile];
	bgSprite.anchorPoint = ccp(0.0, 0.0);
	
	NSString *txtFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"title-text-hd.png" : @"title-text.png");
	CCSprite *txtSprite = [CCSprite spriteWithFile:txtFile];
	txtSprite.position = ccp(screenSize.width / 2.0, screenSize.height / 2.0 + 100.0 * [Chain2AppDelegate screenScale]);
	[txtSprite setOpacity:0];
	
	[scene addChild:bgSprite];
	[scene addChild:txtSprite];
	
	Explosion *exp1 = [[Explosion alloc] init];
	Explosion *exp2 = [[Explosion alloc] init];
	Explosion *exp3 = [[Explosion alloc] init];
	exp1.position = ccp(screenSize.width / 2.0 - 50.0, screenSize.height / 2.0 + 100.0 * [Chain2AppDelegate screenScale]);
	exp2.position = ccp(screenSize.width / 2.0, screenSize.height / 2.0 + 80.0 * [Chain2AppDelegate screenScale]);
	exp3.position = ccp(screenSize.width / 2.0 + 40.0, screenSize.height / 2.0 + 120.0 * [Chain2AppDelegate screenScale]);
	
	CCCallFuncND *act1 = [CCCallFuncND actionWithTarget:scene selector:@selector(addExplosion:data:) data:exp1];
	CCCallFuncND *act2 = [CCCallFuncND actionWithTarget:scene selector:@selector(addExplosion:data:) data:exp2];
	CCCallFuncND *act3 = [CCCallFuncND actionWithTarget:scene selector:@selector(addExplosion:data:) data:exp3];
	[scene runAction:[CCSequence actions:
					  act1, [CCDelayTime actionWithDuration:0.15],
					  act2, [CCDelayTime actionWithDuration:0.15],
					  act3,
					  nil]];
	[txtSprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5], [CCFadeIn actionWithDuration:0.2], nil]];
	
	
	CCMenu *menu = [CCMenu menuWithItems:nil];
	menu.position = ccp(screenSize.width / 2.0, screenSize.height / 2.0 - 90.0 * [Chain2AppDelegate screenScale]);
	
	NSString *newGameFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"new-game-hd.png" : @"new-game.png");
	CCMenuItemImage *newGameBtn = [CCMenuItemImage itemFromNormalImage:newGameFile selectedImage:newGameFile target:scene selector:@selector(startGame:)];
	[menu addChild:newGameBtn];
	
	NSString *highScoresFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"high-scores-hd.png" : @"high-scores.png");
	CCMenuItemImage *highScoresBtn = [CCMenuItemImage itemFromNormalImage:highScoresFile selectedImage:highScoresFile target:scene selector:@selector(showHighScores:)];
	[menu addChild:highScoresBtn];
	
	NSString *settingsFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"settings-hd.png" : @"settings.png");
	CCMenuItemImage *settingsBtn = [CCMenuItemImage itemFromNormalImage:settingsFile selectedImage:settingsFile target:scene selector:@selector(showSettings:)];
	[menu addChild:settingsBtn];
	
	[menu alignItemsVerticallyWithPadding:15.0];
	[scene addChild:menu];
	
	CCLabel *copyrightLbl = [CCLabel labelWithString:@"www.omegaHern.com" fontName:@"Helvetica" fontSize:(9.0 * [Chain2AppDelegate screenScale])];
	[scene addChild:copyrightLbl];
	copyrightLbl.position = ccp(screenSize.width / 2.0, [copyrightLbl boundingBox].size.height / 2.0);
	
	return scene;
}

-(void) addExplosion:(id)sender data:(void*)data {
	[self addChild:(CCNode *)data];
}

-(void) showTutorial {
	[[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
	_tutVC = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController" bundle:[NSBundle mainBundle]];
	
	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionMoveIn];
	[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"ShowTutorial"];
	
	[view addSubview:_tutVC.view];
}

// Menu Actions
-(void) startGame:(CCMenuItem *)sender {
	if ([((Chain2AppDelegate *)[[UIApplication sharedApplication] delegate]) showTutorial])
		[self showTutorial];
	else
		[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:0.3 scene:[GameScene scene]]];
}

-(void) showHighScores:(CCMenuItem *)sender {
	_scoresVC = [[HighScoresViewController alloc] initWithNibName:@"HighScoresViewController" bundle:[NSBundle mainBundle]];
	
	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionMoveIn];
	[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"ShowHighScores"];
	
	[view addSubview:_scoresVC.view];
}

-(void) showSettings:(CCMenuItem *)sender {
	_settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
	
	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionMoveIn];
	[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"ShowSettings"];
	
	[view addSubview:_settingsVC.view];
}

-(void) dealloc {
	[_settingsVC release];
	[_scoresVC release];
	[super dealloc];
}

@end
