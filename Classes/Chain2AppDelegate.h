//
//  Chain2AppDelegate.h
//  Chain2
//
//  Created by Charles Magahern on 9/23/10.
//  Copyright omegaHern 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chain2AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow	*window;
	
	NSUInteger	numberOfDots;
	BOOL		showTutorial;
}

@property (nonatomic, retain) UIWindow *window;

-(NSUInteger) numberOfDots;
-(BOOL)	showTutorial;
-(void) setNumberOfDots:(NSUInteger)n;
-(void) setShowTutorial:(BOOL)b;

+(CGFloat) screenScale;

@end
