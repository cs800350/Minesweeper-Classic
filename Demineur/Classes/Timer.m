//
//  Timer.m
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 08/04/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
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
	int maxTime = MAX_TIME;
	if(currentTime<maxTime)
	{
		currentTime++;
	}
	
	return currentTime;
}


- (void)dealloc 
{	
	[timer release];
    [super dealloc];
}

@end
