//
//  ViewController.m
//  GettingAttention
//
//  Created by Mason Mei on 8/6/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize userOutput;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUserOutput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doAlert:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Button Selected" message:@"I need your attention Now!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)doMultiButtonAlert:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Button Selected" message:@"I need your attention Now!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Maybe Later", @"Never", nil];
    [alertView show];
}

- (IBAction)doAlertInput:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Email Address" message:@"Please Enter your email address!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];

}

- (IBAction)doActionSheet:(id)sender {
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Available Actions" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destory" otherButtonTitles:@"Negotiate", @"Compromise", nil ];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showFromRect:[(UIButton * )sender frame] inView:self.view animated:YES];
}

- (IBAction)doSound:(id)sender {
    SystemSoundID soundId;
    NSString *soundFile=[[NSBundle mainBundle] pathForResource:@"soundeffect" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundId);
    AudioServicesPlaySystemSound(soundId);
}

- (IBAction)doAlertSound:(id)sender {
    SystemSoundID soundId;
    NSString *soundFile=[[NSBundle mainBundle] pathForResource:@"soundeffect" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundId);
    AudioServicesPlayAlertSound(soundId);
}

- (IBAction)doVibration:(id)sender {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Maybe Later"]){
        self.userOutput.text = @"Click 'Maybe Later'";
    }else if([buttonTitle isEqualToString:@"Never"]){
        self.userOutput.text = @"Click 'Never'";
    }else {
        self.userOutput.text = @"Click 'OK'";
    }
    
    if([alertView.title isEqualToString:@"Email Address"]){
        self.userOutput.text = [[alertView textFieldAtIndex:0]text];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Destory"]){
        self.userOutput.text = @"Click 'Destory'";
    }else if([buttonTitle isEqualToString:@"Negotiate"]){
        self.userOutput.text = @"Click 'Negotiate'";
    }else if([buttonTitle isEqualToString:@"Compromise"]){
        self.userOutput.text = @"Click 'Compromise'";
    }else {
        self.userOutput.text = @"Click 'Cancel'";
    }
    
}
@end
