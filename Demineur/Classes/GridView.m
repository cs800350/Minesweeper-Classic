//
//  GridView.m
//  Demineur
//
//  Created by Shyn on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"
#import "GameSquare.h"

@implementation GridView

@synthesize gridDataSource;
@synthesize caseOuverte;
@synthesize caseFermee;
@synthesize caseBombe;
@synthesize caseFlag;
@synthesize valuesColors;


- (id) initWithCoder:(NSCoder *)aCoder
{
    if(self = [super initWithCoder:aCoder])
	{
		caseFlag = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseFlag.png"]];
		caseFermee = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"case.png"]];
		caseOuverte = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseOuverte.png"]];
		caseBombe = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseBomb.png"]];
		
		valuesColors = [[NSArray alloc] initWithObjects:[UIColor blueColor] , [UIColor greenColor], 
						[UIColor redColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor brownColor], nil];
    }
			   
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

	int nbCasesX = [self.gridDataSource getGridWidth];
	int nbCasesY = [self.gridDataSource getGridHeigth];
	
	int cell_width = CELL_WIDTH;
	int cell_heigth = CELL_HEIGTH;
	
	int grid_width = cell_width * nbCasesX;
	int grid_heigth = cell_heigth * nbCasesY;
	
	float xPadding = (rect.size.width - grid_width) /2;
	float yPadding = (rect.size.height - grid_heigth) /2;
	
	// Dessiner les cases de la map, chaque case étant un bouton
	for(int i=0; i<nbCasesX; i++)
	{
		for(int j=0; j<nbCasesY; j++)
		{			
			// Créer le rect ou sera déssinée la case
			CGRect gs_rect = CGRectMake(i*cell_width + xPadding, j*cell_heigth + yPadding, cell_width, cell_heigth);
			
			GameSquare *gameSquare = [[GameSquare alloc] initWithFrame:gs_rect];
			gameSquare.coordX = i;
			gameSquare.coordY = j;
			
			//Choix des images pour la case
			//Cases fermées
			//
			if ([self.gridDataSource getCellState:i withY:j]==0) 
			{
				//Case avec drapeau
				//
				if([self.gridDataSource hasFlag:i withY:j]==1)
				{
					// Ajouter l'image de la case avec un drapeau
					[gameSquare setBackgroundColor:self.caseFlag];
				}
				else 
				{
					// Ajouter l'image de la case fermée 
					[gameSquare setBackgroundColor:self.caseFermee];
				}
		
			}
			
			//Cases ouvertes
			//
			else if ([self.gridDataSource getCellState:i withY:j]==1)
			{		
				int value = [self.gridDataSource getCellValue:i withY:j];
				
				//Case avec bombe
				//
				if(value==-1)
				{
					// Ajouter l'image de la case avec une bombe
					[gameSquare setBackgroundColor:self.caseBombe];
				}
				else 
				{
					//[strechableCaseImageOuverte drawInRect:gs_rect];
					//gameSquare.backgroundColor = caseOuverte;
					[gameSquare setBackgroundColor:self.caseOuverte];
					
					int value = [self.gridDataSource getCellValue:i withY:j];
					
					//Case ouverte avec une valeur
					//
					if(value!=-1 && value!=0)
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
						[label release];
						[str_value release];
					}
				}
			}

			
			//Add gesture recognizer
			//
			UITapGestureRecognizer *uiTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self.gridDataSource action:@selector(discloseSquare:)];
			[gameSquare addGestureRecognizer:uiTapGestureRecognizer];
			[uiTapGestureRecognizer release];
			
			// Ajouter le bouton à la vue
			[self addSubview:gameSquare];
			[gameSquare release];

		}
	}
}


- (void)dealloc 
{	
	//Release background images
	//
	[caseFlag release];
	[caseOuverte release];
	[caseFermee release];
	[caseBombe release];
	
	[valuesColors release];
	
    [super dealloc];
}


@end
