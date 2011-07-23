//
//  HighScoresViewController.m
//  Chain2
//
//  Created by Charles Magahern on 10/1/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import "HighScoresViewController.h"
#import "HighScoresController.h"
#import "cocos2d.h"

@implementation HighScoresViewController
@synthesize noScoresView, scoresTableView;

-(void) viewDidLoad {
    [super viewDidLoad];
	
	_highScores = [[NSArray alloc] initWithArray:[[HighScoresController sharedHighScoresInstance] highScores]];
	
	if ([_highScores count] == 0)
		[noScoresView setHidden:NO];
	else
		[noScoresView setHidden:YES];
	
	CGRect noScoresRect = [noScoresView bounds];
    noScoresRect.origin.x = round( ((self.view.frame.size.width - noScoresRect.size.width) / 2.0) );
	noScoresRect.origin.y = round( (self.view.frame.size.height / 2.0) - (noScoresRect.size.height / 2.0) );
	[noScoresView setFrame:noScoresRect];
	[self.view addSubview:noScoresView];
	
	[scoresTableView setBackgroundColor:[UIColor clearColor]];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellID = @"HighScoreCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
    }

	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	if (indexPath.row >= 3)
		cell.textLabel.text = [[NSString stringWithFormat:@"%uth.   ", indexPath.row + 1] stringByAppendingString:[[_highScores objectAtIndex:indexPath.row] stringValue]];
	else
		cell.textLabel.text = [[_highScores objectAtIndex:indexPath.row] stringValue];
	
	switch (indexPath.row) {
		case 0:
			cell.imageView.image = [UIImage imageNamed:@"1st-place.png"];
			break;
		case 1:
			cell.imageView.image = [UIImage imageNamed:@"2nd-place.png"];
			break;
		case 2:
			cell.imageView.image = [UIImage imageNamed:@"3rd-place.png"];
			break;
	}
	
	return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_highScores count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(IBAction) doneButtonTapped:(id)sender {
	EAGLView *view = [[CCDirector sharedDirector] openGLView];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.4];
	[animation setType:kCATransitionReveal];
	[animation setSubtype:kCATransitionFromBottom];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[[view layer] addAnimation:animation forKey:@"SwitchBackToMainMenu"];
	
	[self.view removeFromSuperview];
}

-(IBAction) clearButtonTapped:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear All Scores" otherButtonTitles:nil];
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			[[HighScoresController sharedHighScoresInstance] clearHighScores];
			_highScores = [NSArray arrayWithArray:[[HighScoresController sharedHighScoresInstance] highScores]];
			[scoresTableView reloadData];
			[noScoresView setHidden:NO];
			break;
		default:
			break;
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
