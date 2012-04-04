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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

	int nbCasesX = [self.gridDataSource getGridWidth];
	int nbCasesY = [self.gridDataSource getGridHeigth];
	
	// Image de la case non découverte
	/*UIImage *caseImageFermee = [UIImage imageNamed:@"case.png"];
	UIImage *strechableCaseImageFermee = [caseImageFermee stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	UIImage *caseImageOuverte = [UIImage imageNamed:@"caseOuverte.png"];
	UIImage *strechableCaseImageOuverte = [caseImageOuverte stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	UIImage *caseBombe = [UIImage imageNamed:@"caseBomb.png"];
	UIImage *strechableCaseBombe = [caseBombe stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	UIImage *caseFlag = [UIImage imageNamed:@"caseFlag.png"];
	UIImage *strechableCaseFlag = [caseFlag stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	*/
	
	UIColor *caseFlag = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseFlag.png"]];
	UIColor *caseFermee = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"case.png"]];
	UIColor *caseOuverte = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseOuverte.png"]];
	UIColor *caseBombe = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"caseBombe.png"]];
	
	// Dessiner les cases de la map, chaque case étant un bouton
	for(int i=0; i<nbCasesX; i++)
	{
		for(int j=0; j<nbCasesY; j++)
		{			
			// Créer le rect ou sera déssinée la case
			CGRect gs_rect = CGRectMake(i*(rect.size.width/nbCasesX), j*(rect.size.height/nbCasesY), rect.size.width/nbCasesX, rect.size.height/nbCasesY);
			
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
					//[strechableCaseFlag drawInRect:gs_rect];
					//gameSquare.backgroundColor = caseFlag;
					[gameSquare setBackgroundColor:caseFlag];
				}
				else 
				{
					// Ajouter l'image de la case fermée 
					//[strechableCaseImageFermee drawInRect:gs_rect];
					//gameSquare.backgroundColor = caseFermee;
					[gameSquare setBackgroundColor:caseFermee];
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
					//[strechableCaseBombe drawInRect:gs_rect];
					//gameSquare.backgroundColor = caseBombe;
					[gameSquare setBackgroundColor:caseBombe];
				}
				else 
				{
					//[strechableCaseImageOuverte drawInRect:gs_rect];
					//gameSquare.backgroundColor = caseOuverte;
					[gameSquare setBackgroundColor:caseOuverte];
					
					//int value = [self.gridDataSource getCellValue:i withY:j];
					
					//Case ouverte avec une valeur
					//
					if(value!=-1 && value!=0)
					{
						//Afficher la valeur de la case
						//
						/*
						NSString *str_value = [[NSString alloc] initWithFormat:@"%d",value];
						UILabel *label = [[UILabel alloc]initWithFrame:gameSquare.frame];
						label.text = str_value;
						label.textColor = [UIColor whiteColor];
						label.backgroundColor = [UIColor clearColor];
						label.font = [UIFont fontWithName:@"arial" size:30.0];
						label.textAlignment = UITextAlignmentCenter;
						[str_value release];
						
						//[gameSquare insertSubview:label atIndex:0];
						[gameSquare addSubview:label];
						[label release];
						 */
					}
				}
			}
			
			//Afficher la valeur de la case
			//
			int value = [self.gridDataSource getCellValue:i withY:j];

			NSString *str_value = [[NSString alloc] initWithFormat:@"%d",value];
			UILabel *label = [[UILabel alloc]initWithFrame:gs_rect];
			label.text = str_value;
			label.textColor = [UIColor blackColor];
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont fontWithName:@"arial" size:30.0];
			label.textAlignment = UITextAlignmentCenter;
			
			//[gameSquare insertSubview:label atIndex:0];
			[gameSquare addSubview:label];
			[label release];
			[str_value release];
			
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
	
	//Release background images
	//
	[caseFlag release];
	[caseOuverte release];
	[caseFermee release];
	[caseBombe release];
}


- (void)dealloc {
    [super dealloc];
}


@end
