//
//  GridModel.m
//  Demineur
//
//  Created by Antoine on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GridModel.h"


@implementation GridModel


//Properties implementation
//
@synthesize nbMines;
@synthesize gridWidth;
@synthesize gridHeigth;
@synthesize gridValues;
@synthesize gridFlags;
@synthesize gridState;
@synthesize currentNbFlag;
@synthesize currentNbDiscloses;


//Constructors implementation and dealloc
//
-(GridModel*) initWithDifficulty:(enum difficulties)difficulty
{
	self = [super init];
	
	//Get grid parameters
	//
	if (difficulty == BEGINER)
	{
		self.gridWidth = WIDTH_BEGINER;
		self.gridHeigth = HEIGTH_BEGINER;
		self.nbMines = NBMINES_BEGINER;
	}
	else if(difficulty == MEDIUM)
	{
		self.gridWidth = WIDTH_MEDIUM;
		self.gridHeigth = HEIGTH_MEDIUM;
		self.nbMines = NBMINES_MEDIUM;
	}
	else if(difficulty == HARD)
	{
		self.gridWidth = WIDTH_HARD;
		self.gridHeigth = HEIGTH_HARD;
		self.nbMines = NBMINES_HARD;
	}
	else 
	{
		//Default or unknow case, return a beginer grid
		//
		self.gridWidth = WIDTH_BEGINER;
		self.gridHeigth = HEIGTH_BEGINER;
		self.nbMines = NBMINES_BEGINER;
	}
	
	//Initialization of grids values, flags, and state
	//
	self.gridValues = [GridModel generateGridValues:self.gridWidth withHeigth:self.gridHeigth withMines:self.nbMines];
	self.gridFlags = [GridModel generateEmptyGrid:self.gridWidth withHeigth:self.gridHeigth withEmptyValue:0];
	self.gridState = [GridModel generateEmptyGrid:self.gridWidth withHeigth:self.gridHeigth withEmptyValue:0];
	
	return self;
}

- (void) dealloc
{
	//Dealloc gridValues
	//
	if (self.gridValues) 
	{
		
		for (int i = 0; i < self.gridWidth; i++) 
		{
			free(self.gridValues[i]);
		}
		
		free(self.gridValues);
		self.gridValues = nil;
	}
	
	//Dealloc gridFlags
	//
	if (self.gridFlags) 
	{
		
		for (int i = 0; i < self.gridWidth; i++) 
		{
			free(self.gridFlags[i]);
		}
		
		free(self.gridFlags);
		self.gridFlags = nil;
	}
	
	//Dealloc gridState
	//
	if (self.gridState) 
	{
		
		for (int i = 0; i < self.gridWidth; i++) 
		{
			free(self.gridState[i]);
		}
		
		free(self.gridState);
		self.gridState = nil;
	}
	
	
	[super dealloc];
}


//Instance methods implementation
//
-(int)getCellValue:(int)x withY:(int)y
{
	if (x > -1 && x < self.gridWidth) 
	{
		if (y > -1 && y < self.gridHeigth) 
		{
			return self.gridValues[x][y];
		}
	}
	
	return -3;
}

-(void)discloseCell:(int)x withY:(int)y
{
	if (x > -1 && x < self.gridWidth) 
	{
		if (y > -1 && y < self.gridHeigth) 
		{
			if(self.gridState[x][y] == 0 && self.gridFlags[x][y]==0)
			{
				self.gridState[x][y] = 1;
				self.currentNbDiscloses += 1;
				
				//
				//
				if(self.gridValues[x][y]==0)
				{
					//Disclose near blocks
					//
					int xFrom = x - 1 ;
					if (xFrom<0) { xFrom = 0; }
					
					int xTo = x + 1;
					if (xTo>self.gridWidth-1) { xTo = self.gridWidth -1; }
					
					int yFrom = y - 1 ;
					if (yFrom<0) { yFrom = 0; }
					
					int yTo = y + 1;
					if (yTo>self.gridHeigth-1) { yTo = self.gridHeigth -1; }
					
					for (int i=xFrom; i<=xTo; i++) 
					{
						for (int j=yFrom; j<=yTo; j++) 
						{
							[self discloseCell:i withY:j];
						}
					}
				}
			}
		}
	}
}

-(bool)putFlag:(int)x withY:(int)y
{
	if (x > -1 && x < self.gridWidth) 
	{
		if (y > -1 && y < self.gridHeigth) 
		{
			if(self.gridFlags[x][y] == 0)
			{
				self.gridFlags[x][y] = 1;
				self.currentNbFlag = self.currentNbFlag + 1;
				return true;
			}
			return false;
		}
	}
	
	return false;
}

-(bool)removeFlag:(int)x withY:(int)y
{
	if (x > -1 && x < self.gridWidth) 
	{
		if (y > -1 && y < self.gridHeigth) 
		{
			if(self.gridFlags[x][y] == 1)
			{
				self.gridFlags[x][y] = 0;
				self.currentNbFlag = self.currentNbFlag - 1;
				return true;
			}
			return false;
		}
	}
	
	return false;
}

-(bool)hasFlag:(int)x withY:(int)y
{
	if(self.gridFlags[x][y]==1)
	{
		return YES;
	}
	else 
	{
		return NO;
	}

}

-(void)discloseGrid
{
	for (int i=0; i<self.gridWidth; i++) 
	{
		for (int j=0; j<self.gridHeigth; j++)
		{
			// Only disclose the square if it doesn't contain a flag AND does contain a bomb
			// or if the flag is put in a quare that does not contain a bomb
			if(self.gridValues[i][j]==-1 && self.gridFlags[i][j]==0 || self.gridValues[i][j]!=-1 && self.gridFlags[i][j]==1)
			{
				self.gridState[i][j]=1;
			}
		}
	}
}

-(bool)didWin
{
	int noMineSquares = gridWidth*gridHeigth-self.nbMines;
	if(self.currentNbDiscloses == noMineSquares)
	{
		return YES;
	}
	
	return NO;
}

-(int)getCellState:(int)x withY:(int)y
{
	if (x > -1 && x < self.gridWidth) 
	{
		if (y > -1 && y < self.gridHeigth) 
		{
			return self.gridState[x][y];
		}
	}
	
	return -3;
}

// Theorical number of mines remaining depending on the number of flags the user has put
-(int)minesRemaining
{
	return self.nbMines-self.currentNbFlag;
}

//Class methods implementation
//
+(int**)generateGridValues:(int)width withHeigth:(int)heigth withMines:(int)mines
{
	int** grid_values = [GridModel generateEmptyGrid:width withHeigth:heigth withEmptyValue:0]; 
	
	int nbmines = 0;
	while (nbmines < mines) 
	{
		int mine_locX = (0 + (arc4random () % (width-1)));
		int mine_locY = (0 + (arc4random () % (heigth-1)));
		
		//If x and y are valid coord
		//
		if (mine_locX > -1 && mine_locX < width) 
		{
			if (mine_locY > -1 && mine_locY < heigth) 
			{
				if(grid_values[mine_locX][mine_locY] != -1)
				{
					//Add the mine at x,y
					//
					grid_values[mine_locX][mine_locY] = -1;
					nbmines = nbmines+1;
					
					//Update values in near blocks
					//
					int xFrom = mine_locX - 1 ;
					if (xFrom<0) { xFrom = 0; }
					
					int xTo = mine_locX + 1;
					if (xTo>width-1) { xTo = width -1; }
					
					int yFrom = mine_locY - 1 ;
					if (yFrom<0) { yFrom = 0; }
					
					int yTo = mine_locY + 1;
					if (yTo>heigth-1) { yTo = heigth -1; }
					
					for (int i=xFrom; i<=xTo; i++) 
					{
						for (int j=yFrom; j<=yTo; j++) 
						{
							//Update count of mine at i,j
							//
							if(grid_values[i][j]!=-1)
							{
								grid_values[i][j] = grid_values[i][j] + 1;
							}
						}
					}
				}
			}
		}
	}
	
	return grid_values;
}

+(int**)generateEmptyGrid:(int)width withHeigth:(int)heigth withEmptyValue:(int)emptyValue
{
	int** emptyGrid;
	
	emptyGrid = (int**) malloc(width*sizeof(int*));
	
	for (int i = 0; i < width; i++)
	{
		emptyGrid[i] = (int*) malloc(heigth*sizeof(int));
	}
	
	//int emptyGrid[width][heigth];
	
	for (int i = 0; i < width; i++) 
	{
		for (int j = 0; j < heigth; j++) 
		{
			emptyGrid[i][j] = emptyValue;
		}
	}
	
	return emptyGrid;
}

@end
