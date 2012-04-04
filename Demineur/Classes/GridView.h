//
//  GridView.h
//  Demineur
//
//  Created by Shyn on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSquare.h"

@protocol GridDataSource

@required
- (int)getCellValue:(int)x withY:(int)y;
- (int)getCellState:(int)x withY:(int)y;
- (int)hasFlag:(int)x withY:(int)y;
- (int)getGridWidth;
- (int)getGridHeigth;
- (void)discloseSquare:(UITapGestureRecognizer *)sender;

@end


@interface GridView : UIView {
	
@private id<GridDataSource> gridDataSource;
	
}

@property (assign)id<GridDataSource> gridDataSource;

@end
