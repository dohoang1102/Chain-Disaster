//
//  TitleScene.h
//  Chain2
//
//  Created by Charles Magahern on 9/26/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SettingsViewController.h"
#import "HighScoresViewController.h"
#import "TutorialViewController.h"

@interface TitleScene : CCScene {
	SettingsViewController		*_settingsVC;
	HighScoresViewController	*_scoresVC;
	TutorialViewController		*_tutVC;
}

+(id) scene;
-(void) startGame:(CCMenuItem *)sender;
-(void)addExplosion:(id)sender data:(void*)data;

@end
