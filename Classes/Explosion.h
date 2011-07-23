//
//  Explosion.h
//  Chain2
//
//  Created by Charles Magahern on 9/24/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chain2AppDelegate.h"
#import "cocos2d.h"

#define EXPLOSION_GROW_SPEED	1.0
#define EXPLOSION_FADE_SPEED	1.0
#define EXPLOSION_SCALE			5.0
#define EXPLOSION_START_RADIUS	6.5

@interface Explosion : CCNode<CCRGBAProtocol> {
	GLubyte		opacity;
	ccColor3B	color;
	
	BOOL		dissipated;
}

@property (nonatomic, assign) GLubyte opacity;
@property (nonatomic, assign) ccColor3B color;
@property (assign) BOOL dissipated;

@property (nonatomic, readonly, getter=getDiameter) CGFloat diameter;

@end
