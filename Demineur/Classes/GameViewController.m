    //
//  GameViewController.m
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GridModel.h"
#import "GridView.h"
 
@interface GameViewController() <GridDataSource>
@end


@implementation GameViewController

@synthesize gridBrain;
@synthesize gridView;
@synthesize gameFinished;
@synthesize victory;

- (id)initWithDifficulty:(enum difficulties)difficulty 
{
    self = [super init];
    if (self) {
        // Initialization code.
		self.gridBrain = [[GridModel alloc] initWithDifficulty:difficulty];
		
		for (UIView *ui in self.view.subviews) 
		{
			if ([ui isKindOfClass:[GridView class]]) 
			{
				((GridView *)ui).gridDataSource = self;
				self.gridView = ((GridView *)ui);
				break;
			}
		}
    }
    return self;
}

- (void)discloseSquare:(UITapGestureRecognizer *)sender
{
	if(self.gameFinished) return;
		
	GameSquare *gs = (GameSquare*)sender.view;
	[self.gridBrain discloseCell:gs.coordX withY:gs.coordY];
	
	int cellValue = [self.gridBrain getCellValue:gs.coordX withY:gs.coordY];
	
	//Mine -> game finished
	//
	if(cellValue==-1)
	{
		[self.gridBrain discloseGrid];
		self.gameFinished = YES;
		self.victory = NO;
		
		UIAlertView *finishBox = [[UIAlertView alloc] initWithTitle:@"Fin de partie" message:@"Vous avez perdu !"
													   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[finishBox show];
		[finishBox release];	
	}
	
	[self.gridView setNeedsDisplay];
}

- (int)getCellValue:(int)x withY:(int)y
{
	return self.gridBrain.gridValues[x][y];
}

- (int)getCellState:(int)x withY:(int)y
{
	return self.gridBrain.gridState[x][y];
}

- (int)hasFlag:(int)x withY:(int)y
{
	return self.gridBrain.gridFlags[x][y];
}

- (int)getGridWidth
{
	return self.gridBrain.gridWidth;
}

- (int)getGridHeigth
{
	return self.gridBrain.gridHeigth;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

/*
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	int nbCasesX = self.gridBrain.gridWidth;
	int nbCasesY = self.gridBrain.gridHeigth;
	
	// Image de la case non découverte
	UIImage *caseImageFermee = [UIImage imageNamed:@"case.png"];
	UIImage *strechableCaseImageFermee = [caseImageFermee stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	UIImage *caseImageOuverte = [UIImage imageNamed:@"caseOuverte.png"];
	UIImage *strechableCaseImageOuverte = [caseImageOuverte stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	// Dessiner les cases de la map, chaque case étant un bouton
	for(int i=0; i<nbCasesX; i++)
	{
		for(int j=0; j<nbCasesY; j++)
		{		
			// Créer le bouton
			CGRect gs_rect = CGRectMake(i*self.gridView.frame.size.width/nbCasesX, j*self.gridView.frame.size.height/nbCasesY, self.gridView.frame.size.width/nbCasesX, self.gridView.frame.size.height/nbCasesY);
			
			//Case fermée
			//
			if ([self getCellState:i withY:j]==0) 
			{
				//Case avec drapeau
				//
				if([self hasFlag:i withY:j])
				{
					//TODO
				}
				else 
				{
					// Ajouter l'image de la case fermée au bouton
					[strechableCaseImageFermee drawInRect:gs_rect];
				}
				
			}
			
			//Case ouverte
			//
			else if ([self getCellState:i withY:j]==1)
			{
				int value = [self getCellValue:i withY:j];
				
				//Case avec bombe
				//
				if(value==-1)
				{
					//TODO
				}
				else 
				{
					[strechableCaseImageOuverte drawInRect:gs_rect];
					
					//NSString *str = [[NSString alloc] initWithFormat:@"%d",value];
					//[gameSquare setTitle:str forState:UIControlStateNormal];
					//[str release];
				}
			}
			
			GameSquare *gameSquare = [[GameSquare alloc] initWithFrame:gs_rect];
			
			gameSquare.coordX = i;
			gameSquare.coordY = j;
			
			//
			//
			UITapGestureRecognizer *uiTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discloseSquare:)];
			[gameSquare addGestureRecognizer:uiTapGestureRecognizer];
			[uiTapGestureRecognizer release];
			
			// Ajouter le bouton à la vue
			[self addSubview:gameSquare];
			[gameSquare release];
		}
	}
}
*/

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
