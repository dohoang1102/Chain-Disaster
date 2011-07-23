//
//  SettingsViewController.h
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chain2AppDelegate.h"

@interface SettingsViewController : UIViewController<UIAlertViewDelegate> {
	IBOutlet UISlider *dotsSlider;
	IBOutlet UISwitch *tutorialSwitch;
	
	Chain2AppDelegate *_appDelegate;
}

@property (nonatomic, retain) UISlider *dotsSlider;
@property (nonatomic, retain) UISwitch *tutorialSwitch;

-(void) saveData;
-(IBAction) doneButtonTapped:(id)sender;

@end
