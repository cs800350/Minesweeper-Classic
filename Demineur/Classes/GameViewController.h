//
//  GameViewController.h
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridModel.h"
#import "GridView.h"
#import "GameSquare.h"
#import "Timer.h"


@interface GameViewController : UIViewController {

@private
	GridModel *gridBrain;
	GridView *gridView;
	Timer *timer;
	
	bool gameFinished;
	bool victory;
}

@property (retain) GridModel *gridBrain;
@property (retain) GridView *gridView;
@property (retain) Timer *timer;

@property bool gameFinished;
@property bool victory;

//Constructors
//
- (id)initWithDifficulty:(enum difficulties)difficulty;

//Methods
//



@end
