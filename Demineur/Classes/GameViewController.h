//
//  GameViewController.h
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridModel.h"


@interface GameViewController : UIViewController {
@private
	GridModel *gridBrain;
}

@property (retain) GridModel *gridBrain;

// Constructors
//
- (id)initWithDifficulty:(enum difficulties)difficulty;

@end
