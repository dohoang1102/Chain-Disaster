//
//  Dot.h
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Chain2AppDelegate.h"
#import "cocos2d.h"

#define DOT_MOVEMENT_SPEED 70.0
#define DOT_RADIUS 5.0

@interface Dot : CCNode {
	CGFloat xVelocity;
	CGFloat yVelocity;
}

@property (nonatomic, assign) CGFloat xVelocity;
@property (nonatomic, assign) CGFloat yVelocity;

@property (nonatomic, readonly, getter=getDiameter) CGFloat diameter;

@end
