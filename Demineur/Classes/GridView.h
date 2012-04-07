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

@end


@interface GridView : UIView {
	
@private id<GridDataSource> gridDataSource;
	
	UIColor *caseOuverte;
	UIColor *caseFermee;
	UIColor *caseBombe;
	UIColor *caseFlag;
	NSArray *valuesColors;	
}

@property (assign)id<GridDataSource> gridDataSource;

@property (retain)UIColor *caseOuverte;
@property (retain)UIColor *caseFermee;
@property (retain)UIColor *caseBombe;
@property (retain)UIColor *caseFlag;
@property (retain)NSArray *valuesColors;

@end
