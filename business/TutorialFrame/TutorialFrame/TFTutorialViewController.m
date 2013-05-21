//
//  TFTutorialViewController.m
//  TutorialFrame
//
//  Created by Mason Mei on 4/11/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "TFTutorialViewController.h"

@interface TFTutorialViewController ()

@end

@implementation TFTutorialViewController
@synthesize moviePlayerController = _moviePlayerController;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startPlayingVideo:(id)paramSender{
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.jplayer.org/video/m4v/Finding_Nemo_Teaser.m4v"];
    //create our movie Player
    
    if(_moviePlayerController != nil){
        [self stopPlayingVideo:nil];
    }
    
    _moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    if(_moviePlayerController != nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoHasFinishedPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayerController];
        NSLog(@"successfully instantiated the movie player");
        
        _moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
        
        [_moviePlayerController play];
        [self.view addSubview:_moviePlayerController.view];
        [_moviePlayerController setFullscreen:YES animated:YES];
    } else {
        NSLog(@"Failed to instantiated the movie player.");
    }
}

-(void) videoHasFinishedPlaying:(NSNotification *) paramNotification{
    NSNumber *reason = [paramNotification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if(reason != nil){
        NSInteger reasonInt = [reason integerValue];
        switch (reasonInt) {
            case MPMovieFinishReasonPlaybackEnded:{
                break;
            }
            case MPMovieFinishReasonPlaybackError:{
                break;
            }
            case MPMovieFinishReasonUserExited:{
                break;
            }
        }
        NSLog(@"Finish Reason = %ld", (long)reasonInt);
        [self stopPlayingVideo:nil];
    }
}


@end
