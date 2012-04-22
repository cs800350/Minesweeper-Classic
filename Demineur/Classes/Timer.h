//
//  Timer.h
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 08/04/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAX_TIME 999;

@interface Timer : NSObject {
@private
	NSTimer *timer;
	int currentTime;
}

@property (retain) NSTimer *timer;
@property int currentTime;

-(void)start;
-(void)stop;
-(int)secondsElapsed;

@end
