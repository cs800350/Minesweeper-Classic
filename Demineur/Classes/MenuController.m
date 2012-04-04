    //
//  MenuController.m
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "GameViewController.h"
#import "GridModel.h"

@implementation MenuController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (id)init
{
	if([super init]) 
	{
		self.title = @"Menu";
		return self;
	} else {
		return nil;
	}
}

- (IBAction)startGamePressed:(UIButton *)sender
{
	enum difficulties difficulty;
	
	if([sender.titleLabel.text isEqual:@"Débutant"]) 
	{
		difficulty = BEGINER;
	} 
	else if([sender.titleLabel.text isEqual:@"Intermédiaire"]) 
	{
		difficulty = MEDIUM;
	}
	else if([sender.titleLabel.text isEqual:@"Avance"]) 
	{
		difficulty = HARD;
	}
	
	GameViewController *gc = [[GameViewController alloc] initWithDifficulty:difficulty];
	[self.navigationController pushViewController:gc animated:YES];
	[gc release];
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


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
