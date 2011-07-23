//
//  Dot.m
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "Dot.h"
#import "CCDrawingPrimitives.h"
#import "Chain2AppDelegate.h"

@implementation Dot
@synthesize xVelocity, yVelocity;
@synthesize diameter;

-(id) init {
	if ((self = [super init])) {
		CGSize s = [[CCDirector sharedDirector] displaySize];
		CGFloat x = fmod(arc4random(), s.width);
		CGFloat y = fmod(arc4random(), s.height);
		self.position = ccp(x, y);
		
		self.xVelocity = (rand() % 2 == 0 ? DOT_MOVEMENT_SPEED + (rand() % 10) : -DOT_MOVEMENT_SPEED - (rand() % 10));
		self.yVelocity = (rand() % 2 == 0 ? DOT_MOVEMENT_SPEED + (rand() % 10) : -DOT_MOVEMENT_SPEED - (rand() % 10));
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(CGFloat) getDiameter {
	return (DOT_RADIUS * 2.0 * [Chain2AppDelegate screenScale]);
}

-(void) draw {
	glColor4ub(255, 255, 255, 255);
	ccDrawCircle(ccp(0.0, 0.0), DOT_RADIUS * [Chain2AppDelegate screenScale], 0.0, 360, 1);
}

-(void) update:(ccTime)dt {
	CGSize s = [[CCDirector sharedDirector] displaySize];
	
	CGFloat nextX = self.position.x + self.xVelocity * dt;
	CGFloat nextY = self.position.y + self.yVelocity * dt;
	
	if (nextX - DOT_RADIUS <= 0) {
		self.position = ccp(DOT_RADIUS, self.position.y);
		self.xVelocity = -self.xVelocity;
	} else if (nextX + DOT_RADIUS >= s.width) {
		self.position = ccp(s.width - DOT_RADIUS, self.position.y);
		self.xVelocity = -self.xVelocity;
	}
	
	if (nextY - DOT_RADIUS <= 0) {
		self.position = ccp(self.position.x, DOT_RADIUS);
		self.yVelocity = -self.yVelocity;
	} else if (nextY + DOT_RADIUS >= s.height) {
		self.position = ccp(self.position.x, s.height - DOT_RADIUS);
		self.yVelocity = -self.yVelocity;
	}
	
	self.position = ccp(self.position.x + self.xVelocity * dt * [Chain2AppDelegate screenScale],
						self.position.y + self.yVelocity * dt * [Chain2AppDelegate screenScale]);
}

@end
