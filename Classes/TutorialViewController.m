//
//  TutorialViewController.m
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "TutorialViewController.h"
#import "Chain2AppDelegate.h"
#import "cocos2d.h"
#import "GameScene.h"

@implementation TutorialViewController

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) dismiss {
	[[CCDirector sharedDirector] replaceScene:[GameScene scene]];

	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionReveal];
	[animation setSubtype:kCATransitionFromBottom];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"SwitchBackToMainMenu"];
	
	[self.view removeFromSuperview];
}

-(IBAction) okButtonTapped:(id)sender {
	[self dismiss];
}

-(IBAction) dontShowAgainButtonTapped:(id)sender {
	[((Chain2AppDelegate *)[[UIApplication sharedApplication] delegate]) setShowTutorial:NO];
	[self dismiss];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidUnload {
    [super viewDidUnload];
}

-(void) dealloc {
    [super dealloc];
}


@end
