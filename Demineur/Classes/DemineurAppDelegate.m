//
//  DemineurAppDelegate.m
//  Demineur
//
//  Created by Antoine on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DemineurAppDelegate.h"

//TODO A ENLEVER
//
#import "GridModel.h"

@implementation DemineurAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	
	NSLog(@"Memory Warning");
	
	//Unit tests empty grid
	//
	int width=9;
	int heigth=9;
	
	int** emptygrid = [GridModel generateEmptyGrid:width withHeigth:heigth withEmptyValue:0];
	
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < heigth; j++) {
			
			NSLog(@"Unit Test - Empty Grid : x=%d y=%d value=%d",i,j,emptygrid[i][j]);
		}
	}
	
	//Free emptygrid
	//
	for (int i = 0; i < width; i++) 
	{
		free(emptygrid[i]);
	}
	
	free(emptygrid);
	
	//Unit tests empty grid
	//
	//GridModel *grid = [[GridModel alloc]initWithDifficulty:BEGINER];
	//[grid autorelease];
	
	
	
	int **grid = [GridModel generateGridValues:width withHeigth:heigth withMines:10]; 
	
	for (int i = 0; i < width; i++) {
		
		NSMutableString *line = [[NSMutableString alloc] init];
		[line retain];
		
		for (int j = 0; j < heigth; j++) {
			
			[line appendFormat:@"%d",grid[i][j]];
			//NSLog(@"Unit Test - Grid : x=%d y=%d value=%d",i,j,grid[i][j]);
		}
		NSLog(@"line : %@",line);
		[line release];
	}
	
	//Free grid
	//
	for (int i = 0; i < width; i++) 
	{
		free(grid[i]);
	}
	
	free(grid);
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
