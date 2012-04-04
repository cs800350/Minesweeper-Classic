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
}

@property (retain) GridModel *gridBrain;
@property (retain) GridView *gridView;

//Constructors
//
- (id)initWithDifficulty:(enum difficulties)difficulty;

//Methods
//



@end
