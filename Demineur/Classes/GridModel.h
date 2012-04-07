//
//  GridModel.h
//  Demineur
//
//  Created by Antoine on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WIDTH_MAX 16 ;
#define HEIGTH_MAX 22 ;

#define WIDTH_BEGINER 9 ;
#define HEIGTH_BEGINER 9 ;
#define NBMINES_BEGINER 10 ;

#define WIDTH_MEDIUM 16 ;
#define HEIGTH_MEDIUM 16 ;
#define NBMINES_MEDIUM 40 ;

#define WIDTH_HARD 17 ;
#define HEIGTH_HARD 21 ;
#define NBMINES_HARD 70;

enum difficulties {BEGINER, MEDIUM, HARD};

@interface GridModel : NSObject 
{

@private

	int nbMines;
	int gridWidth;
	int gridHeigth;
	int currentNbFlag;
	
	//Location of mines and number of nears mines in each cases
	//
	int **gridValues;
	
	//Location of flags put by the player
	//
	int **gridFlags;
	
	//Cells opened by the player
	//
	int **gridState;

}

@property int nbMines;
@property int gridWidth;
@property int gridHeigth;
@property int currentNbFlag;
@property int **gridValues;
@property int **gridFlags;
@property int **gridState;


//Constrcutors
//
-(GridModel*) initWithDifficulty:(enum difficulties)difficulty;


//Instance methods
//
-(int)getCellValue:(int)x withY:(int)y;
-(void)discloseCell:(int)x withY:(int)y;
-(bool)putFlag:(int)x withY:(int)y;
-(bool)removeFlag:(int)x withY:(int)y;
-(int)getCellState:(int)x withY:(int)y;
-(void)discloseGrid;

//Class methods
//
+(int**)generateGridValues:(int)width withHeigth:(int)heigth withMines:(int)mines;
+(int**)generateEmptyGrid:(int)width withHeigth:(int)heigth withEmptyValue:(int)emptyValue;

@end
