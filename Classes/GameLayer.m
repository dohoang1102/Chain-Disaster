//
//  GameLayer.m
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "GameLayer.h"
#import "TitleScene.h"
#import "Dot.h"
#import "HighScoresController.h"

NSMutableSet	*_explosions;
BOOL			_chainBegan;
CCColorLayer	*_blkOverlay;
GameOverDialog  *_gameOverDialg;

@implementation GameLayer
@synthesize game, scoreLabel;

-(id) init {
	if ((self = [super init])) {
		[self scheduleUpdate];
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
														 priority:0
												  swallowsTouches:YES];
	}
	
	return self;
}

-(void) setGame:(Game *)g {
	game = g;
	
	unsigned int n = 0;
	for (id child in [self children]) {
		if ([child isKindOfClass:[Dot class]])
			n++;
	}
	
	for (int i = 0; i < (game.numberOfDots - n); i++)
		[self addChild:[Dot node]];
	
	if (self.scoreLabel == nil) {
		self.scoreLabel = [CCLabel labelWithString:@"Score: 0" fontName:@"Helvetica-BoldOblique" fontSize:(15 * [Chain2AppDelegate screenScale])];
		CGSize screen = [[CCDirector sharedDirector] displaySize];
		self.scoreLabel.position = ccp(0.0 + [self.scoreLabel boundingBox].size.width / 2, screen.height - [self.scoreLabel boundingBox].size.height / 2);
		[self addChild:self.scoreLabel];
	} else {
		[scoreLabel setString:[NSString stringWithFormat:@"Score: 0"]];
	}

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScoreLabel) name:@"scoreUpdated" object:game];
	
	if (_explosions == nil)
		_explosions = [[NSMutableSet alloc] initWithCapacity:game.numberOfDots];
	
	_chainBegan = NO;
}

BOOL checkCircleCollision(CGRect circle, CGRect circleTwo) {
	CGPoint circleOnePoint = circle.origin;
	CGPoint circleTwoPoint = circleTwo.origin;
	
	float circleOneRadius = (circle.size.width / 2);
	float circleTwoRadius = (circleTwo.size.width / 2);
	
	float xdif = circleOnePoint.x - circleTwoPoint.x;
	float ydif = circleOnePoint.y - circleTwoPoint.y;
	
	float distance = sqrt(xdif * xdif + ydif * ydif);
	
	if (distance <= circleOneRadius + circleTwoRadius)
		return YES;
	
	return NO;
}

-(BOOL) explodeAt:(CGPoint)p {
	Explosion *exp = [Explosion node];
	exp.position = p;
	
	[self addChild:exp];
	[_explosions addObject:exp];
	
	return YES;
}

-(void) gameOver {
	_blkOverlay = [CCColorLayer layerWithColor:ccc4(0, 0, 0, 255)];
	_blkOverlay.opacity = 0;
	[self addChild:_blkOverlay];
	[_blkOverlay runAction:[CCFadeTo actionWithDuration:0.3 opacity:150]];
	
	_gameOverDialg = [GameOverDialog node];
	_gameOverDialg.score = game.score;
	_gameOverDialg.delegate = self;
	
	_gameOverDialg.position = ccp([[CCDirector sharedDirector] displaySize].width / 2.0, [[CCDirector sharedDirector] displaySize].height / 2.0);
	_gameOverDialg.opacity = 0;
	_gameOverDialg.scale = 0.7;
	
	[_blkOverlay addChild:_gameOverDialg];
	[_gameOverDialg runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.25],
												  [CCSpawn actions:[CCScaleTo actionWithDuration:0.15 scale:1.0], [CCFadeIn actionWithDuration:0.15], nil],
												  nil]];
	
	[[HighScoresController sharedHighScoresInstance] addHighScore:game.score];
}

-(void) newGameButtonClicked {
	self.game = [[Game alloc] initWithNumberOfDots:game.numberOfDots];
	_chainBegan = NO;
	[self resumeSchedulerAndActions];
}

-(void) mainMenuButtonClicked {
	[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:0.3 scene:[TitleScene scene]]];
}

-(void) gameOverMenuDismissed {
	[_gameOverDialg runAction:[CCSequence actions:
							   [CCSpawn actions:[CCScaleTo actionWithDuration:0.15 scale:0.7], [CCFadeOut actionWithDuration:0.15], nil],
							   [CCCallFunc actionWithTarget:_gameOverDialg selector:@selector(remove)],
							   nil]];
	[_blkOverlay runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.2],
							[CCCallFunc actionWithTarget:_blkOverlay selector:@selector(removeFromParentAndCleanup:)],
							nil]];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	if (!_chainBegan) {
		CGPoint loc = [touch locationInView:[touch view]];
		loc = [[CCDirector sharedDirector] convertToGL:loc];
		[self explodeAt:loc];
		
		_chainBegan = YES;
	}
	
	return YES;
}

-(void) update:(ccTime)dt {
	
	Explosion *expToRm = nil;
	for (id item in _explosions) {
		Explosion *explosion = (Explosion *) item;
		
		if (explosion.dissipated) {
			expToRm = explosion;
		} else {
			CGRect expRect = CGRectMake(explosion.position.x, explosion.position.y, explosion.diameter, explosion.diameter);
			
			Dot *dotToRm = nil;
			for (id child in [self children]) {
				if ([child isKindOfClass:[Dot class]]) {
					Dot *dot = (Dot *) child;
					CGRect dotRect = CGRectMake(dot.position.x, dot.position.y, dot.diameter, dot.diameter);
					
					if (checkCircleCollision(dotRect, expRect)) {
						dotToRm = dot;
					}
				}
			}
			
			if (dotToRm != nil) {
				[self explodeAt:dotToRm.position];
				[dotToRm removeFromParentAndCleanup:NO];
				game.score++;
			}
		}
	}
	
	if (expToRm != nil) {
		[_explosions removeObject:expToRm];
		[expToRm removeFromParentAndCleanup:YES];
	}
	
	if ([_explosions count] == 0 && _chainBegan) {
		[self pauseSchedulerAndActions];
		[self gameOver];
	}
}

-(void) updateScoreLabel {
	[scoreLabel setString:[NSString stringWithFormat:@"Score: %d", game.score]];
	self.scoreLabel.position = ccp(0.0 + [self.scoreLabel boundingBox].size.width / 2, self.scoreLabel.position.y);
}

-(void) dealloc {
	[_explosions release];
	[game release];
	
	[super dealloc];
}

@end
