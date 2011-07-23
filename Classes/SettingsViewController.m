//
//  SettingsViewController.m
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "SettingsViewController.h"
#import "HighScoresController.h"
#import "cocos2d.h"

@implementation SettingsViewController
@synthesize dotsSlider, tutorialSwitch;

-(void) viewDidLoad {
    [super viewDidLoad];
	
	_appDelegate = (Chain2AppDelegate *) [[UIApplication sharedApplication] delegate];
	
	[dotsSlider setValue:(float)_appDelegate.numberOfDots];
	[tutorialSwitch setOn:_appDelegate.showTutorial];
}

-(void) dismiss {
	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionReveal];
	[animation setSubtype:kCATransitionFromBottom];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"SwitchBackToMainMenu"];
	
	[self.view removeFromSuperview];
}

-(void) saveData {
	[_appDelegate setNumberOfDots:((int) [dotsSlider value])];
	[_appDelegate setShowTutorial:[tutorialSwitch isOn]];
}

-(IBAction) doneButtonTapped:(id)sender {
	if (_appDelegate.numberOfDots != (int)dotsSlider.value) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Changing the number of dots will erase all high scores. Continue?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert autorelease];
	} else {
		[self saveData];
		[self dismiss];
	}
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [dotsSlider setValue:[_appDelegate numberOfDots] animated:YES];
            break;
        case 1:
        {
            [[HighScoresController sharedHighScoresInstance] clearHighScores];
			[self saveData];
			[self dismiss];
            break;
        }
    }
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
