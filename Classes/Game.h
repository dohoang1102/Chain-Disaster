//
//  Game.h
//  Chain2
//
//  Created by Charles Magahern on 9/24/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject {
	NSUInteger numberOfDots;
	NSUInteger score;
}

@property (nonatomic, assign) NSUInteger numberOfDots;
@property (nonatomic, assign, setter=setScore:) NSUInteger score;

-(id) initWithNumberOfDots:(NSUInteger)dots;
-(void) setScore:(NSUInteger)s;

@end
