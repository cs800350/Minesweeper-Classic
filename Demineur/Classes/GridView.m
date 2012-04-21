//
//  GridView.m
//  Demineur
//
//  Created by Shyn on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"
#import "GameSquare.h"

@implementation GridView

@synthesize gridDataSource;
@synthesize caseOuverte;
@synthesize caseFermee;
@synthesize caseBombe;
@synthesize caseFlag;
@synthesize caseExploded;
@synthesize caseFlagMode;
@synthesize valuesColors;


- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
	{
		caseFlag     = [UIImage imageNamed:@"caseFlag.png"];
		caseFermee   = [UIImage imageNamed:@"case.png"];
		caseOuverte  = [UIImage imageNamed:@"caseOuverte.png"];
		caseBombe    = [UIImage imageNamed:@"caseBomb.png"];
		caseExploded = [UIImage imageNamed:@"caseExploded.png"];
		caseFlagMode = [UIImage imageNamed:@"caseFlagMode.png"];
		
		valuesColors = [[NSArray alloc] initWithObjects:[UIColor blueColor] , [UIColor greenColor], 
						[UIColor redColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor brownColor], nil];
	}
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {

}*/

-(void)dealloc 
{	
	//Release background images
	//
	[caseFlag release];
	[caseOuverte release];
	[caseFermee release];
	[caseBombe release];
	
	[valuesColors release];
	
    [super dealloc];
}


@end
