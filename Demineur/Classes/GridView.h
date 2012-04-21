//
//  GridView.h
//  Demineur
//
//  Created by Shyn on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSquare.h"

#define CELL_WIDTH 45 ;
#define CELL_HEIGTH 45 ;


@protocol GridDataSource

@required
- (int)getCellValue:(int)x withY:(int)y;
- (int)getCellState:(int)x withY:(int)y;
- (int)hasFlag:(int)x withY:(int)y;
- (int)getGridWidth;
- (int)getGridHeigth;
- (void)discloseSquare:(UITapGestureRecognizer *)sender;
- (void)toggleFlag:(UITapGestureRecognizer *)sender;
- (int)lastTouchedX;
- (int)lastTouchedY;
- (bool)flagMode;

@end


@interface GridView : UIView {
	
@private id<GridDataSource> gridDataSource;
	
	UIImage *caseOuverte;
	UIImage *caseFermee;
	UIImage *caseBombe;
	UIImage *caseFlag;
	UIImage *caseExploded;
	UIImage *caseFlagMode;
	NSArray *valuesColors;	
}

@property (assign)id<GridDataSource> gridDataSource;

@property (retain)UIImage *caseOuverte;
@property (retain)UIImage *caseFermee;
@property (retain)UIImage *caseBombe;
@property (retain)UIImage *caseFlag;
@property (retain)UIImage *caseExploded;
@property (retain)UIImage *caseFlagMode;
@property (retain)NSArray *valuesColors;

@end
