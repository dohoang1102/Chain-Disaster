//
//  GameOverDialog.h
//  Chain2
//
//  Created by Charles Magahern on 9/30/10.
//  Copyright 2010 omegaHern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol GameOverMenuDelegate<NSObject>

-(void) newGameButtonClicked;
-(void) mainMenuButtonClicked;
-(void) gameOverMenuDismissed;

@end


@interface GameOverDialog : CCNode<CCRGBAProtocol> {
	NSUInteger	score;

	GLubyte		opacity;
	ccColor3B	color;
	
	CCLabel *_scoreLbl;
	
	id<GameOverMenuDelegate> delegate;
}

@property (nonatomic, assign, setter=setScore:) NSUInteger score;
@property (nonatomic, readonly) GLubyte opacity;
@property (nonatomic, readonly) ccColor3B color;

@property (nonatomic, retain) id<GameOverMenuDelegate> delegate;

-(void) playAgain:(CCMenuItem *)sender;
-(void) mainMenu:(CCMenuItem *)sender;
-(void) remove;

@end
