//
//  MenuController.h
//  Demineur
//
//  Created by Antoine Boulinguez and Shyn-Yuan CHENG on 28/03/12.
//  Copyright 2012 M1 Miage - Université de Nice Sophia-Antipolis. All rights reserved.
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
