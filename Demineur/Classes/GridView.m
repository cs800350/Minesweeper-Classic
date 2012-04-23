//
//  GridView.m
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 28/03/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
//

#import "GridView.h"
#import "GameSquare.h"

@implementation GridView

@synthesize gridDataSource;
@synthesize caseOuverte;
@synthesize caseFermee;
@synthesize caseBombe;
@synthesize caseFlag;
@synthesize caseExploded;
@synthesize caseFlagMode;
@synthesize caseWrongFlag;
@synthesize valuesColors;
@synthesize listSquares;

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
	{
		caseFlag     = [UIImage imageNamed:@"caseFlag.png"];
		caseFermee   = [UIImage imageNamed:@"case.png"];
		caseOuverte  = [UIImage imageNamed:@"caseOuverte.png"];
		caseBombe    = [UIImage imageNamed:@"caseBomb.png"];
		caseExploded = [UIImage imageNamed:@"caseExploded.png"];
		caseFlagMode = [UIImage imageNamed:@"caseFlagMode.png"];
		caseWrongFlag = [UIImage imageNamed:@"caseWrongFlag.png"];
		
		valuesColors = [[NSArray alloc] initWithObjects:[UIColor blueColor] , [UIColor greenColor], 
						[UIColor redColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor brownColor], nil];
	}
	return self;
}

-(void)updateGridView
{
	int i = 0;
	int j = 0;
	
	for (NSMutableArray *colsArray in self.listSquares) 
	{
		j = 0;
		for (GameSquare *gameSquare in colsArray) 
		{
			//Choix des images pour la case
			//Cases fermées
			//
			if ([self.gridDataSource getCellState:i withY:j]==0) 
			{
				//Case avec drapeau
				//
				if([self.gridDataSource hasFlag:i withY:j])
				{
					// Ajouter l'image de la case avec un drapeau
					[gameSquare setImage:self.caseFlag];
				}
				else 
				{
					if([self.gridDataSource flagMode] && ![self.gridDataSource gameFinished])
					{
						// Add the square image in flag mode
						[gameSquare setImage:self.caseFlagMode];
					}
					else {
						// Add the square image in normal mode
						[gameSquare setImage:self.caseFermee];
					}
					
				}
			}
			
			//Cases ouvertes
			//
			else if([self.gridDataSource getCellState:i withY:j]==1)
			{		
				int value = [self.gridDataSource getCellValue:i withY:j];
				
				//Case avec bombe
				//
				if(value==-1)
				{
					if([self.gridDataSource lastTouchedX]==i && [self.gridDataSource lastTouchedY] == j)
					{
						// Add cthe square image containing the exploded bomb
						[gameSquare setImage:self.caseExploded];
					}
					else {
						// Add cthe square image containing the bomb
						[gameSquare setImage:self.caseBombe];
					}
					
				}
				else 
				{
					[gameSquare setImage:self.caseOuverte];
					
					// Wrong flag - When the player lost and has placed a flag on a square that doesn't contain a bomb
					// this square is disclosed by the model
					if([self.gridDataSource hasFlag:i withY:j] && [self.gridDataSource gameFinished] && ![self.gridDataSource victory])
					{
						[gameSquare setImage:self.caseWrongFlag];
					}
					
					//Case ouverte avec une valeur
					//
					else if(value!=-1 && value!=0 && !gameSquare.label)
					{
						CGRect gs_rect2 = CGRectMake(0, 0, gameSquare.frame.size.width, gameSquare.frame.size.height);
						
						NSString *str_value = [[NSString alloc] initWithFormat:@"%d",value];
						
						UILabel *label = [[UILabel alloc]initWithFrame:gs_rect2];
						label.text = str_value;
						label.backgroundColor = [UIColor clearColor];
						label.font = [UIFont fontWithName:@"arial" size:30.0];
						label.textAlignment = UITextAlignmentCenter;
						
						//Text color
						//
						if(value <= [self.valuesColors count])
						{
							int index = value - 1;
							label.textColor = (UIColor*)[self.valuesColors objectAtIndex:index];
						}
						else 
						{
							label.textColor = [UIColor blackColor];
						}
						
						[gameSquare addSubview:label];
						gameSquare.label = label;
						[label release];
						[str_value release];
					}
				}
			}
			
			j++;
		}
		i++;
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {

}*/

-(void)dealloc 
{	
	//Release background images
	//
	[caseFlag release];
	[caseOuverte release];
	[caseFermee release];
	[caseBombe release];
	[caseExploded release];
	[caseFlagMode release];
	[caseWrongFlag release];
	[listSquares release];
	
	[valuesColors release];
	
    [super dealloc];
}


@end
