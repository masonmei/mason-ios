//
//  ViewController.m
//  MediaPlayground
//
//  Created by Mason Mei on 9/3/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize toggleFullscreen;
@synthesize recordButton;
@synthesize toggleCamera;
@synthesize displayImageView;
@synthesize musicPlayButton;
@synthesize displayNowPlaying;
@synthesize moviePlayer;
@synthesize audioRecoder;
@synthesize audioPlayer;
@synthesize musicPlayer;

- (void)viewDidLoad
{
    NSString *movieFile = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"m4v"];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:movieFile]];
    self.moviePlayer.allowsAirPlay=YES;
    [self.moviePlayer.view setFrame:CGRectMake(145.0, 20.0, 155.0, 100.0)];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"sound.caf"]];
    NSDictionary *soundSetting;
    soundSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                    [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                    [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
                    [NSNumber numberWithInt: AVAudioQualityHigh], AVEncoderAudioQualityKey,nil];
    self.audioRecoder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:soundSetting error:nil];
    
    NSURL *noSoundFileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"norecording" ofType:@"wav"]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:noSoundFileURL error:nil];
    
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setToggleFullscreen:nil];
    [self setRecordButton:nil];
    [self setToggleCamera:nil];
    [self setDisplayImageView:nil];
    [self setMusicPlayButton:nil];
    [self setDisplayNowPlaying:nil];
    [self setMoviePlayer:nil];
    [self setAudioRecoder:nil];
    [self setAudioPlayer:nil];
    [self setMoviePlayer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)playMovie:(id)sender {
    [self.view addSubview:self.moviePlayer.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    if([self.toggleFullscreen isOn]){
        [self.moviePlayer setFullscreen:YES animated:YES];
    }
    [self.moviePlayer play];
}

- (IBAction)recordAudio:(id)sender {
    if([self.recordButton.titleLabel.text isEqualToString:@"Record Audio"]){
        [self.audioRecoder record];
        [self.recordButton setTitle:@"Stop Recording" forState:UIControlStateNormal];
    } else {
        [self.audioRecoder stop];
        [self.recordButton setTitle:@"Record Audio" forState:UIControlStateNormal];
        NSURL *soundFileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"sound.caf"]];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    }
}

- (IBAction)playAudio:(id)sender {
    [self.audioPlayer play];
}

- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    
    if([self.toggleCamera isOn]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)applyFilter:(id)sender {
    CIImage *imageToFilter;
    imageToFilter = [[CIImage alloc] initWithImage:self.displayImageView.image];
    CIFilter *activeFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [activeFilter setDefaults];
    [activeFilter setValue:[NSNumber numberWithFloat:0.75] forKey:@"inputIntensity"];
    [activeFilter setValue:imageToFilter forKey:@"inputImage"];
    CIImage *filteredImage = [activeFilter valueForKey:@"outputImage"];
    //UIImage *myNewImage = [UIImage imageWithCIImage:filteredImage];
    CIContext *context = [CIContext contextWithOptions:[NSDictionary dictionary]];
    CGImageRef cgImage = [context createCGImage:filteredImage fromRect:[imageToFilter extent]];
    UIImage *myNewImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    self.displayImageView.image = myNewImage;
}

- (IBAction)chooseMusic:(id)sender {
    MPMediaPickerController *musicPicker;
    [self.musicPlayer stop];
    self.displayNowPlaying.text = @"No Song Playing";
    [self.musicPlayButton setTitle:@"Play Music" forState:UIControlStateNormal];
    musicPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    musicPicker.prompt = @"Choose Songs to Play";
    musicPicker.allowsPickingMultipleItems = YES;
    musicPicker.delegate = self;
    
    [self presentModalViewController:musicPicker animated:YES];
}

- (IBAction)playMusic:(id)sender {
    if([self.musicPlayButton.titleLabel.text isEqualToString:@"Play Music"]){
        [self.musicPlayer play];
        [self.musicPlayButton setTitle:@"Pause Music" forState:UIControlStateNormal];
        self.displayNowPlaying.text = [self.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    } else {
        [self.musicPlayer pause];
        [self.musicPlayButton setTitle:@"Play Music" forState:UIControlStateNormal];
        self.displayNowPlaying.text = @"No Song Playing";
    }
}

-(void) playMovieFinished:(NSNotification *)theNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [self.moviePlayer.view removeFromSuperview];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissModalViewControllerAnimated:YES];
    self.displayImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    [musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissModalViewControllerAnimated:YES];
}
@end
