//
//  GameSquare.h
//  Demineur
//
//  Created by Antoine on 04/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameSquare : UIView {

	@private
	int coordX;
	int coordY;
}

@property int coordX;
@property int coordY;

@end