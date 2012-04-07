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


@interface GameViewController : UIViewController {

@private
	GridModel *gridBrain;
	GridView *gridView;
	
	bool gameFinished;
	bool victory;
}

@property (retain) GridModel *gridBrain;
@property (retain) GridView *gridView;

@property bool gameFinished;
@property bool victory;

//Constructors
//
- (id)initWithDifficulty:(enum difficulties)difficulty;

//Methods
//



@end
