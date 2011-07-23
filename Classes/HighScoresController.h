//
//  HighScoresController.h
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoresController : NSObject {
	NSMutableArray *highScores;
}

@property (nonatomic, readonly, retain) NSMutableArray *highScores;

+(HighScoresController *) sharedHighScoresInstance;

-(void) addHighScore:(NSUInteger)s;
-(void) clearHighScores;

@end
