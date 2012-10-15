//
//  ViewController.m
//  SimonSays
//
//  Created by Mason Mei on 9/16/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Make the background black
    self.view.backgroundColor = [UIColor blackColor];
    // Add shape views to this view
    ShapeView* sv;
    sv = [[ShapeView alloc]
          initWithFrame:CGRectMake(10, 10, 140, 140) shape:SQUARE];
    [self.view addSubview:sv];
    
    sv = [[ShapeView alloc]
          initWithFrame:CGRectMake(170, 10, 140, 140) shape:CIRCLE];
    [self.view addSubview:sv];
    
    sv = [[ShapeView alloc]
          initWithFrame:CGRectMake(10, 170, 140, 140) shape:TRIANGLE];
    [self.view addSubview:sv];
    
    sv = [[ShapeView alloc]
          initWithFrame:CGRectMake(170, 170, 140, 140) shape:PENTAGON];
    [self.view addSubview:sv];
    
    // Configure and add Simon Label to the view
    simonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 260, 40)];
    simonLabel.backgroundColor=[UIColor blackColor];
    simonLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:simonLabel];
    
    // Seed the random number generator
    srandom( time( NULL ) );
    
    // Initialize simonSaid
    simonSaid = NO;
    timerLength = 2.0;
    
    // Get the simon string and start the game
    [self getSimonString];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)getSimonString{
    int simonSaysNum, shapeNum;
    simonSaysNum = (random() % 3);
    shapeNum = (random() % 4);
    NSMutableString* simonString = [[NSMutableString alloc] init];
    if (simonSaysNum == 0)
    {
        [simonString appendString:@"Simon says "];
        simonSaid = YES;
    }
    else
    {
        simonSaid = NO;
    }
    [simonString appendString:@"touch the "];
    switch (shapeNum) {
        case TRIANGLE:
            [simonString appendString:@"triangle"];
            break;
        case CIRCLE:
            [simonString appendString:@"circle"];
            break;
        case SQUARE:
            [simonString appendString:@"square"];
            break;
        case PENTAGON:
            [simonString appendString:@"pentagon"];
            break;
    }
    shouldTouchShape = shapeNum;
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:timerLength
                                                 target:self
                                               selector:@selector(timerFired:)
                                               userInfo:nil
                                                repeats:NO];
    simonLabel.text = simonString;
    return;
}

-(void)timerFired:(NSTimer *)theTimer{
    if (simonSaid)
    {
        [self endGameWithMessage:@"Simon said, but you didn’t!"];
    }
    else
    {
        // Reward the player
        simonLabel.text = @"Good job!";
        // Get the next simon s tring in 1 second
        [self performSelector:@selector(getSimonString) withObject:nil afterDelay:2];
    }
}

-(void)endGameWithMessage:(NSString *)message{
    // Call this method to end the game
    // Invalidate the timer
    [gameTimer invalidate];
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    // User acknowledged the alert
    // Reset the game and start again
    simonSaid = NO;
    timerLength = 2.0;
    // Get the simon string and start the game
    [self getSimonString];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // Get any touch
    UITouch* t = [touches anyObject];
    // If the touch was on a ShapeView
    if ([t.view class] == [ShapeView class])
    {
        // Get the ShapeView
        ShapeView* sv = (ShapeView*)t.view;
        // Did simon say? If not, end game
        if (!simonSaid)
        {
            // Simon didn’t say!
            [self endGameWithMessage:@"Simon didn’t say!"];
        }
        else
        {
            // Simon said, so make sure correct shape was touched
            if (sv.shape != shouldTouchShape) {
                [self endGameWithMessage:@"You touched the wrong shape!"];
            }
            else
            {
                // Player did the right thing.
                // Invalidate the timer because the player answered correctly
                [gameTimer invalidate];
                // Correct answer makes the timer shorter next time
                timerLength-=0.1;
                // Get the next simon string and start the timer
                // Reward the player
                simonLabel.text = @"Good job!";
                // Get the next simon string in 1 second
                [self performSelector:@selector(getSimonString)withObject:nil afterDelay:1];
            }
        }
    }
}
@end
