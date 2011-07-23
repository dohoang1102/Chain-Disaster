//
//  Explosion.m
//  Chain2
//
//  Created by Charles Magahern on 9/24/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "Explosion.h"


@implementation Explosion
@synthesize opacity, color;
@synthesize dissipated;
@synthesize diameter;

-(CGFloat) getDiameter {
	return (EXPLOSION_START_RADIUS * self.scale * [Chain2AppDelegate screenScale]) * 2.0;
}

-(void) onEnter {
	[super onEnter];
	
	self.color = ccc3(255, 0, 0);
	self.opacity = 255;
	self.dissipated = NO;
	
	CCScaleTo *scale = [CCScaleTo actionWithDuration:(0.3 * EXPLOSION_GROW_SPEED) scale:EXPLOSION_SCALE];
	CCEaseIn *easeScale = [CCEaseOut actionWithAction:scale rate:5];
	CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:(0.8 * EXPLOSION_FADE_SPEED)];
	
	[self runAction:[CCSequence actions:easeScale,
										fadeOut,
										[CCCallFunc actionWithTarget:self selector:@selector(explosionDissapated)],
										nil]];
}

-(void) explosionDissapated {
	self.dissipated = YES;
}

-(void) draw {
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	glColor4ub(self.color.r, self.color.g, self.color.b, self.opacity);
	ccDrawCircle(ccp(0.0, 0.0), EXPLOSION_START_RADIUS * [Chain2AppDelegate screenScale], 0.0, 360, 1);
}

@end
