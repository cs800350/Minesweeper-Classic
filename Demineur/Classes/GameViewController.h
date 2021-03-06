//
//  GameViewController.h
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 28/03/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "GridModel.h"
#import "GridView.h"
#import "GameSquare.h"
#import "Timer.h"


@interface GameViewController : UIViewController {

@private
	GridModel *gridBrain;
	GridView *gridView;
	UIScrollView *scrollView;
	Timer *timer;
	
	bool gameFinished;
	bool victory;
	bool flagMode;
	int lastTouchedX;
	int lastTouchedY;
	
	//Music
	//
	AVAudioPlayer *musicPlayer;
}

@property (retain) GridModel    *gridBrain;
@property (retain) GridView     *gridView;
@property (retain) UIScrollView *scrollView;
@property (retain) Timer        *timer;

@property bool gameFinished;
@property bool victory;
@property bool flagMode;
@property int  lastTouchedX;
@property int  lastTouchedY;

@property (nonatomic, retain) AVAudioPlayer *musicPlayer;

//Constructors
//
- (id)initWithDifficulty:(enum difficulties)difficulty;

//Methods
//



@end
