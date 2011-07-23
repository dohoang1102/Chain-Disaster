//
//  HighScoresController.m
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "HighScoresController.h"


@implementation HighScoresController
@synthesize highScores;

+(HighScoresController *) sharedHighScoresInstance {
	static HighScoresController *sharedHighScoresInstance;
	
	@synchronized(self) {
		if (!sharedHighScoresInstance)
			sharedHighScoresInstance = [[HighScoresController alloc] init];
		
		return sharedHighScoresInstance;
	}
}

-(id) init {
	if ((self = [super init])) {
		NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSString pathWithComponents:docsDir] stringByAppendingPathComponent:@"ChainHighScores.plist"]];
		highScores = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"Scores"]];
	}
	return self;
}

-(void) saveHighScoresToFile {
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"intValue" ascending:NO selector:@selector(compare:)];
	[highScores sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObject:highScores forKey:@"Scores"];
	NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	[dict writeToFile:[[NSString pathWithComponents:docsDir] stringByAppendingPathComponent:@"ChainHighScores.plist"] atomically:YES];
}

-(void) addHighScore:(NSUInteger)s {
	if (![highScores containsObject:[NSNumber numberWithInt:s]]) {
		if ([highScores count] >= 10) 
			[highScores removeLastObject];
		[highScores addObject:[NSNumber numberWithInt:s]];
		[self saveHighScoresToFile];
	}
}

-(void) clearHighScores {
	[highScores removeAllObjects];
	[self saveHighScoresToFile];
}

@end
