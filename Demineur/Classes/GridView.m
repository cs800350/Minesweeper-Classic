//
//  GridView.m
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"
#import "GameSquare.h"


@implementation GridView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	// TODO A remplacer
	int nbCasesX = 16;
	int nbCasesY = 16;
	
	// Image de la case non découverte
	UIImage *caseImage = [UIImage imageNamed:@"case.png"];
	UIImage *strechableCaseImage = [caseImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	// Dessiner les cases de la map, chaque case étant un bouton
	for(int i=0; i<nbCasesY; i++)
	{
		for(int j=0; j<nbCasesX; j++)
		{
			// Modifier la couleur du fond
			self.backgroundColor = [UIColor whiteColor];
			
			// Créer le bouton
			UIButton *buttonCase = [GameSquare buttonWithType:UIButtonTypeRoundedRect];
			
			// Paramétrer la position et la taille du boutton
			buttonCase.frame = CGRectMake(j*rect.size.width/nbCasesX, i*rect.size.height/nbCasesY, rect.size.width/nbCasesX, rect.size.height/nbCasesY);
	
			// Ajouter l'image au bouton
			[buttonCase setBackgroundImage:strechableCaseImage forState:UIControlStateNormal];
			
			// Paramétrer le titre du bouton
			[buttonCase setTitle:@"1" forState:UIControlStateNormal];
			buttonCase.titleLabel.hidden=YES;
			
			// Ajouter le bouton à la vue
			[self addSubview:buttonCase];
		}
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
