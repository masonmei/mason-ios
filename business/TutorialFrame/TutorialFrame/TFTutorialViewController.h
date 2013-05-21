//
//  TFTutorialViewController.h
//  TutorialFrame
//
//  Created by Mason Mei on 4/11/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TFTutorialViewController : UIViewController

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

-(void) startPlayingVideo:(id)paramSender;
-(void) stopPlayingVideo:(id)paramSender;

@end
