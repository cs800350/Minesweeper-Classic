//
//  MenuController.h
//  Demineur
//
//  Created by adminuser on 28/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface MenuController : UIViewController {
	
	//Music
	//
	AVAudioPlayer *musicPlayer;
	
}

@property (nonatomic, retain) AVAudioPlayer *musicPlayer;

- (IBAction)startGamePressed:(UIButton *)sender;

@end
