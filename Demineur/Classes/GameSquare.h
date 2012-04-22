//
//  GameSquare.h
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 04/04/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameSquare : UIImageView {
@private
	int coordX;
	int coordY;
	UILabel *label;
}

@property int coordX;
@property int coordY;
@property (retain) UILabel *label;

@end
