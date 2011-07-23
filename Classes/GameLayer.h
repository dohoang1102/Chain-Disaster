//
//  GameLayer.h
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Game.h"
#import "Explosion.h"
#import "GameOverDialog.h"

@interface GameLayer : CCLayer<GameOverMenuDelegate> {
	Game	*game;
	CCLabel *scoreLabel;
}

@property (nonatomic, retain, setter=setGame:) Game *game;
@property (nonatomic, retain) CCLabel *scoreLabel;

-(BOOL) explodeAt:(CGPoint)p;
-(void) gameOver;
BOOL circleIntersectsCircle(CGRect circle, CGRect circleTwo);

@end
