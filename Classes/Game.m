//
//  Game.m
//  Chain2
//
//  Created by Charles Magahern on 9/24/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "Game.h"


@implementation Game
@synthesize numberOfDots, score;

-(id) init {
	if ((self = [super init])) {
		self.numberOfDots = 50;
		self.score = 0;
	}
	
	return self;
}

-(id) initWithNumberOfDots:(NSUInteger)dots {
	if ((self = [super init])) {
		self.numberOfDots = dots;
		self.score = 0;
	}
	
	return self;
}

-(void) setScore:(NSUInteger)s {
	score = s;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"scoreUpdated" object:self];
}

@end
