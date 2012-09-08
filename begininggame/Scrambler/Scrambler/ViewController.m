//
//  ViewController.m
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scrambleWord;
@synthesize remainingTime;
@synthesize playerScore;
@synthesize guessText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gameModel = [[ScramblerModel alloc] init];
    remainingTime.text = [NSString stringWithFormat:@"%i", gameModel.time];
    playerScore.text = [NSString stringWithFormat:@"%i", gameModel.score];
    scrambleWord.text = [gameModel getScrambledWord];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
}

- (void)viewDidUnload
{
    [self setGuessText:nil];
    [self setScrambleWord:nil];
    [self setRemainingTime:nil];
    [self setPlayerScore:nil];
    gameModel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)guessTap:(id)sender {
    BOOL guessResult = [gameModel checkGuess:guessText.text];
    guessText.text = @"";
    
    if(guessResult){
        if(gameModel.score == 10){
            [self endGameWithMessage:@"You Win!"];
        } else {
            scrambleWord.text = [gameModel getScrambledWord];
        }
    }
    remainingTime.text = [NSString stringWithFormat:@"%i", gameModel.time];
    playerScore.text = [NSString stringWithFormat:@"%i", gameModel.score];
}

-(void)endGameWithMessage:(NSString *)message{
    [timer invalidate];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(void)timerFired:(NSTimer *) theTimer{
    [gameModel timeTick];
    if(gameModel.time <= 0){
        remainingTime.text = @"0";
        [self endGameWithMessage:@"You are out of time. You lose!"];
    } else {
        remainingTime.text = [NSString stringWithFormat:@"%i", gameModel.time];
    }
}
@end
