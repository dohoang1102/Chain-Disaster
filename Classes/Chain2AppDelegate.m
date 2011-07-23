//
//  Chain2AppDelegate.m
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright omegaHern 2010. All rights reserved.
//

#import "Chain2AppDelegate.h"
#import "cocos2d.h"
#import "GameScene.h"
#import "TitleScene.h"

@implementation Chain2AppDelegate

@synthesize window;

+(CGFloat) screenScale {
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
		return [[UIScreen mainScreen] scale];
	else
		return 1.0;
}

-(NSUInteger) numberOfDots {
	if (!numberOfDots)
		numberOfDots = [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfDots"];
	return numberOfDots;
}

-(BOOL) showTutorial {
	if (!showTutorial)
		showTutorial = [[NSUserDefaults standardUserDefaults] boolForKey:@"ShowTutorial"];
	return showTutorial;
}

-(void) setNumberOfDots:(NSUInteger)n {
	numberOfDots = n;
	[[NSUserDefaults standardUserDefaults] setInteger:numberOfDots forKey:@"NumberOfDots"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) setShowTutorial:(BOOL)b {
	showTutorial = b;
	[[NSUserDefaults standardUserDefaults] setBool:showTutorial forKey:@"ShowTutorial"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	CC_DIRECTOR_INIT();
	CCDirector *director = [CCDirector sharedDirector];
	
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	[director setDisplayFPS:NO];
	
	EAGLView *view = [director openGLView];
	[view setMultipleTouchEnabled:NO];
	
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];	
	
	// Enables High Res mode on iPhone 4 and maintains low res on all other devices
	// Don't add if you don't want to enable HighRes mode on iPhone4
	if ([UIScreen instancesRespondToSelector:@selector(scale)])
		[director setContentScaleFactor:[[UIScreen mainScreen] scale]];
		
	[[CCDirector sharedDirector] runWithScene:[TitleScene scene]];
	
	if (!self.numberOfDots) {
		self.numberOfDots = 25;
		self.showTutorial = YES;
	}
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
