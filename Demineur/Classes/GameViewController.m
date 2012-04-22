    //
//  GameViewController.m
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 28/03/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
//

#import "GameViewController.h"
#import "GridModel.h"
#import "GridView.h"
 
@interface GameViewController() <GridDataSource>
@end


@implementation GameViewController

@synthesize gridBrain;
@synthesize gridView;
@synthesize scrollView;
@synthesize gameFinished;
@synthesize victory;
@synthesize timer;
@synthesize flagMode;
@synthesize lastTouchedX;
@synthesize lastTouchedY;
@synthesize musicPlayer;
@synthesize listSquares;

- (id)initWithDifficulty:(enum difficulties)difficulty 
{
    self = [super init];
    if (self) {
        // Initialization code.
		self.gridBrain = [[GridModel alloc] initWithDifficulty:difficulty];
		[gridBrain release];
		
		// Start the timer
		self.timer = [[Timer alloc] init];
		[timer start];
		[timer release];
		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(displayTime) userInfo:nil repeats:YES];
		
		self.title = [NSString stringWithFormat:@"%d sec | %d mines",timer.currentTime, [self.gridBrain minesRemaining]];
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
			if ([self getCellState:i withY:j]==0) 
			{
				//Case avec drapeau
				//
				if([self hasFlag:i withY:j])
				{
					// Ajouter l'image de la case avec un drapeau
					[gameSquare setImage:self.gridView.caseFlag];
				}
				else 
				{
					if([self flagMode])
					{
						// Add the square image in flag mode
						[gameSquare setImage:self.gridView.caseFlagMode];
					}
					else {
						// Add the square image in normal mode
						[gameSquare setImage:self.gridView.caseFermee];
					}

				}
			}
			
			//Cases ouvertes
			//
			else if([self getCellState:i withY:j]==1)
			{		
				int value = [self getCellValue:i withY:j];
				
				//Case avec bombe
				//
				if(value==-1)
				{
					if([self lastTouchedX]==i && [self lastTouchedY] == j)
					{
						// Add cthe square image containing the exploded bomb
						[gameSquare setImage:self.gridView.caseExploded];
					}
					else {
						// Add cthe square image containing the bomb
						[gameSquare setImage:self.gridView.caseBombe];
					}
					
				}
				else 
				{
					[gameSquare setImage:self.gridView.caseOuverte];
	
					// Wrong flag - When the player lost and has placed a flag on a square that doesn't contain a bomb
					// this square is disclosed by the model
					if([self hasFlag:i withY:j] && self.gameFinished && !self.victory)
					{
						[gameSquare setImage:self.gridView.caseWrongFlag];
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
						if(value <= [self.gridView.valuesColors count])
						{
							int index = value - 1;
							label.textColor = (UIColor*)[self.gridView.valuesColors objectAtIndex:index];
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

-(void)displayTime
{
	self.title = [NSString stringWithFormat:@"%d sec | %d mines",timer.currentTime, [self.gridBrain minesRemaining]];
}

- (void)toggleFlag:(int)x withY:(int)y
{
	if(![self.gridBrain putFlag:x withY:y])
	{
		[self.gridBrain removeFlag:x withY:y];
	}
	[self updateGridView];
	[self displayTime];
}

- (void)toggleFlag:(UITapGestureRecognizer *)sender
{
	if(self.gameFinished || sender.state==UIGestureRecognizerStateEnded || sender.state==UIGestureRecognizerStateChanged) return;
	
	GameSquare *gs = (GameSquare*)sender.view;
	[self toggleFlag:gs.coordX withY:gs.coordY];
}

- (int)lastTouchedX
{
	return lastTouchedX;
}

- (int)lastTouchedY
{
	return lastTouchedY;
}

- (void)discloseSquare:(UITapGestureRecognizer *)sender
{
	if(self.gameFinished) return;
		
	GameSquare *gs = (GameSquare*)sender.view;
	
	if(flagMode)
	{
		[self toggleFlag:gs.coordX withY:gs.coordY];
		return;
	}
	
	if([self hasFlag:gs.coordX withY:gs.coordY]) return;
	
	[self.gridBrain discloseCell:gs.coordX withY:gs.coordY];
	
	int cellValue = [self.gridBrain getCellValue:gs.coordX withY:gs.coordY];
	
	//Mine -> game finished
	//
	if(cellValue==-1) // Defeat
	{
		[self.gridBrain discloseGrid];
		self.gameFinished = YES;
		self.victory = NO;
		[timer stop];
		
		// Indicate le last square chose
		lastTouchedX = gs.coordX;
		lastTouchedY = gs.coordY;
		
		UIAlertView *finishBox = [[UIAlertView alloc] initWithTitle:@"Défaite" message:@"Vous avez perdu !"
													   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[finishBox show];
		[finishBox release];
	}
	else if([self.gridBrain didWin]) // Victory
	{
		[self.gridBrain discloseGrid];
		self.gameFinished = YES;
		self.victory = YES;
		
		[timer stop];
		UIAlertView *finishBox = [[UIAlertView alloc] initWithTitle:@"Victoire" 
															message:[NSString stringWithFormat:@"Vous avez gagné ! Temps : %d secondes.", timer.currentTime]
														   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[finishBox show];
		[finishBox release];	
	}

	[self updateGridView];
}

-(void)setFlagMode
{
	flagMode = !flagMode;
	[self updateGridView];
}

-(bool)flagMode
{
	return flagMode;
}

- (int)getCellValue:(int)x withY:(int)y
{
	return [self.gridBrain getCellValue:x withY:y];
}

- (int)getCellState:(int)x withY:(int)y
{
	return [self.gridBrain getCellState:x withY:y];
}

- (bool)hasFlag:(int)x withY:(int)y
{
	return [self.gridBrain hasFlag:x withY:y];
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

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	// Add the flag button on the navigation bar
	UIImage *flagmodeImage = [UIImage imageNamed:@"caseFlag.png"];
	UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[flagButton setImage:flagmodeImage forState:UIControlStateNormal];
	flagButton.frame = CGRectMake(0, 0, flagmodeImage.size.width, flagmodeImage.size.height);
	[flagButton addTarget:self action:@selector(setFlagMode) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:flagButton];
	self.navigationItem.rightBarButtonItem = customBarItem;
	
	//Init music
	//
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"music" ofType: @"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
    [fileURL release];
    self.musicPlayer = newPlayer;
    [newPlayer release];
	
	// Initialize grid
	self.view.userInteractionEnabled = YES;
	CGRect rect = self.view.frame;
	
	int nbCasesX = [self getGridWidth];
	int nbCasesY = [self getGridHeigth];
	
	int cell_width = CELL_WIDTH;
	int cell_heigth = CELL_HEIGTH;
	
	int grid_width = cell_width * nbCasesX;
	int grid_heigth = cell_heigth * nbCasesY;
	
	float xPadding = (rect.size.width - grid_width) /2;
	float yPadding = (rect.size.height - grid_heigth) /2;
	
	// Get current device orientation
	// put the y padding to 0 if orientation is landscape and the grid height is too big (especialy for the hard difficulty)
	int grid_heigth_medium = HEIGTH_MEDIUM;
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	if(self.gridBrain.gridHeigth > grid_heigth_medium && UIInterfaceOrientationIsLandscape(orientation))
	{
		yPadding = 0;
	}
	
	// Create game grid
	CGRect scroll_rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	self.scrollView = [[UIScrollView alloc] initWithFrame:scroll_rect];
	self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.scrollView.contentSize = CGSizeMake(rect.size.width, grid_heigth);
	[self.view addSubview:self.scrollView];
	[self.scrollView release];
	
	CGRect gg_rect = CGRectMake(xPadding, yPadding, grid_width, grid_heigth);
	self.gridView = [[GridView alloc] initWithFrame:gg_rect];
	self.gridView.gridDataSource = self;
	self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin 
									  | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
	[self.scrollView addSubview:self.gridView];
	[self.gridView release];
	
	self.listSquares = [[NSMutableArray alloc] init];
	
	// Dessiner les cases de la map, chaque case étant un bouton
	for(int i=0; i<nbCasesX; i++)
	{
		NSMutableArray *arrayColonnes = [[NSMutableArray alloc] init];
		for(int j=0; j<nbCasesY; j++)
		{			
			// Create the closed game square
			CGRect gs_rect = CGRectMake(i*cell_width, j*cell_heigth, cell_width, cell_heigth);
			GameSquare *gameSquare = [[GameSquare alloc] initWithFrame:gs_rect];
			gameSquare.coordX = i;
			gameSquare.coordY = j;
			
			[gameSquare setImage:self.gridView.caseFermee];
			
			// Add gesture recognizer
			//
			UITapGestureRecognizer *uiTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self 
																									action:@selector(discloseSquare:)];
			[gameSquare addGestureRecognizer:uiTapGestureRecognizer];
			[uiTapGestureRecognizer release];
			
			UILongPressGestureRecognizer *uILongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self 
																													  action:@selector(toggleFlag:)];
			uILongPressGestureRecognizer.minimumPressDuration = 0.5;
			[gameSquare addGestureRecognizer:uILongPressGestureRecognizer];
			[uILongPressGestureRecognizer release];
			
			// Add the square to the view and the list
			[self.gridView addSubview:gameSquare];
			[arrayColonnes addObject:gameSquare];
			[gameSquare release];
		}
		
		[self.listSquares addObject:arrayColonnes];
		[arrayColonnes release];
	}
	
	[self.listSquares release];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	int grid_heigth_medium = HEIGTH_MEDIUM;
	int cell_width = CELL_WIDTH;
	int cell_height = CELL_HEIGTH;
	
	CGRect rect = self.view.frame;
	float grid_width = self.gridBrain.gridWidth*cell_width;
	float grid_heigth = self.gridBrain.gridHeigth*cell_height;
	float xPadding = (rect.size.width - grid_width) /2;
	float yPadding = (rect.size.height - grid_heigth) /2;
	
	// if we are not in beginner mode, fix the position of the gridview after rotation
	if(self.gridBrain.gridHeigth > grid_heigth_medium && UIInterfaceOrientationIsPortrait(fromInterfaceOrientation))
	{
		
		self.scrollView.contentSize = CGSizeMake(rect.size.width, grid_heigth);
		self.gridView.frame = CGRectMake(xPadding, 0, grid_width, grid_heigth);
	}
	else if(self.gridBrain.gridHeigth > grid_heigth_medium && UIInterfaceOrientationIsLandscape(fromInterfaceOrientation))
	{
		self.scrollView.contentSize = CGSizeMake(grid_width, grid_heigth);
		self.gridView.frame = CGRectMake(xPadding, yPadding, grid_width, grid_heigth);
	}
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
	self.musicPlayer.numberOfLoops = -1;
    self.musicPlayer.currentTime = 0;
    self.musicPlayer.volume = 1.0;
    [self.musicPlayer play];
}

-(void) viewWillDisappear:(BOOL)animated
{
	if (self.musicPlayer.playing) 
	{
        [self.musicPlayer stop];
    }
}

-(void)dealloc {
	//Dealloc listSquares
	//
	[listSquares release];
	[gridBrain release];
	[gridView release];
	[timer release];
	[scrollView release];
	
    [super dealloc];
}


@end
