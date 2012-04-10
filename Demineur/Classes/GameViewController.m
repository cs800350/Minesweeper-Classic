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
@synthesize timer;
@synthesize flagMode;
@synthesize lastTouchedX;
@synthesize lastTouchedY;

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
    }
    return self;
}

-(void)displayTime
{
	self.title = [NSString stringWithFormat:@"%d",timer.currentTime];
}

- (void)toggleFlag:(int)x withY:(int)y
{
	int hasFlag = self.gridBrain.gridFlags[x][y];
	self.gridBrain.gridFlags[x][y] = 1 - hasFlag;
	[self.gridView setNeedsDisplay];
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

	[self.gridView setNeedsDisplay];
}

-(void)setFlagMode
{
	flagMode = !flagMode;
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

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	for (UIView *ui in self.view.subviews) 
	{
		if ([ui isKindOfClass:[GridView class]]) 
		{
			((GridView *)ui).gridDataSource = self;
			self.gridView = ((GridView *)ui);
			break;
		}
	}
	
	// Add the flag button on the navigation bar
	UIImage *flagmodeImage = [UIImage imageNamed:@"caseFlag.png"];
	UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[flagButton setImage:flagmodeImage forState:UIControlStateNormal];
	flagButton.frame = CGRectMake(0, 0, flagmodeImage.size.width, flagmodeImage.size.height);
	[flagButton addTarget:self action:@selector(setFlagMode) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:flagButton];
	self.navigationItem.rightBarButtonItem = customBarItem;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[gridBrain release];
	[gridView release];
	[timer release];
	
    [super dealloc];
}


@end
