//
//  Timer.h
//  Demineur
//
//  Created by adminuser on 08/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


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
