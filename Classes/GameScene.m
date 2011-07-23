//
//  GameScene.m
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "Chain2AppDelegate.h"


@implementation GameScene

+(id) scene {
	GameScene *scene = [GameScene node];
	
	NSString *bgFile = ([Chain2AppDelegate screenScale] >= 2.0 ? @"game-bg-hd.png" : @"game-bg.png");
	CCSprite *bgSprite = [CCSprite spriteWithFile:bgFile];
	bgSprite.anchorPoint = ccp(0.0, 0.0);
	
	GameLayer *gameLayer = [GameLayer node];
	
	NSUInteger dots = ((Chain2AppDelegate *) [[UIApplication sharedApplication] delegate]).numberOfDots;
	Game *game = [[Game alloc] initWithNumberOfDots:dots];
	gameLayer.game = game;
	
	[scene addChild:bgSprite];
	[scene addChild:gameLayer];
	
	return scene;
}

@end
