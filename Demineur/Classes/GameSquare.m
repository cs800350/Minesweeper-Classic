//
//  GameSquare.m
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 04/04/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
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
