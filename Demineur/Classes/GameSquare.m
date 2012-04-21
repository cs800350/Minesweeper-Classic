//
//  GameSquare.m
//  Demineur
//
//  Created by Antoine on 04/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSquare.h"

@implementation GameSquare

@synthesize coordX;
@synthesize coordY;
@synthesize label;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


@end
