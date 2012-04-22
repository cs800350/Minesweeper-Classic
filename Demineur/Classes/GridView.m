//
//  GridView.m
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 28/03/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
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
@synthesize caseWrongFlag;
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
		caseWrongFlag = [UIImage imageNamed:@"caseWrongFlag.png"];
		
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
	[caseExploded release];
	[caseFlagMode release];
	[caseWrongFlag release];
	
	[valuesColors release];
	
    [super dealloc];
}


@end
