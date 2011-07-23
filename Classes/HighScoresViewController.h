//
//  HighScoresViewController.h
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoresViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	NSArray *_highScores;
	
	IBOutlet UIView		 *noScoresView;
	IBOutlet UITableView *scoresTableView;
}

@property (nonatomic, retain) UIView *noScoresView;
@property (nonatomic, retain) UITableView *scoresTableView;

-(IBAction) doneButtonTapped:(id)sender;
-(IBAction) clearButtonTapped:(id)sender;

@end
