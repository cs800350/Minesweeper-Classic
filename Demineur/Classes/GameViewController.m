    //
//  GameViewController.m
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GridModel.h"


@implementation GameViewController

@synthesize gridBrain;

- (id)initWithDifficulty:(enum difficulties)difficulty 
{
    self = [super init];
    if (self) {
        // Initialization code.
		// self.gridBrain = [[GridModel alloc] initWithDifficulty:difficulty] autorelease];
    }
    return self;
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
