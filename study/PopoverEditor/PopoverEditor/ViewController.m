//
//  ViewController.m
//  PopoverEditor
//
//  Created by Mason Mei on 8/7/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize emailLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setEmailLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIStoryboardPopoverSegue *popoverSegue;
    popoverSegue = (UIStoryboardPopoverSegue *)segue;
 
    UIPopoverController *popoverController;
    popoverController = popoverSegue.popoverController;
    popoverController.delegate = self;
    
    EditorViewController *editController;
    editController = (EditorViewController *) popoverController.contentViewController;
    editController.emailField.text = self.emailLabel.text;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSString *newEmail = ((EditorViewController *)popoverController.contentViewController).emailField.text;
    self.emailLabel.text = newEmail;
}

@end
