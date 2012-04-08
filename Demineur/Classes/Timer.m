//
//  Timer.m
//  Demineur
//
//  Created by adminuser on 08/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Timer.h"


@implementation Timer

@synthesize timer;
@synthesize currentTime;

- (void)start
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondsElapsed) userInfo:nil repeats:YES];
    //NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //[runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)stop
{
    [timer invalidate];
    timer = nil;
}


-(int)secondsElapsed
{
    currentTime++;
	NSLog(@"%d", currentTime);
	
	return currentTime;
}


- (void)dealloc 
{	
	[timer release];
    [super dealloc];
}

@end
