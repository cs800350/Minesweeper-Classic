//
//  GameSquare.h
//  Demineur
//
//  Created by adminuser on 02/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameSquare : UIButton {
@private
	// Coordinatess of the square on the game grid
	int coordX;
	int coordY;
}

@property int coordX;
@property int coordY;

@end
