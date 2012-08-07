//
//  EditorViewController.m
//  ModalEditor
//
//  Created by Mason Mei on 8/7/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController
@synthesize emailField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.emailField.text = ((ViewController * )self.presentingViewController).emailLabel.text;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEmailField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismissEditor:(id)sender {
    ((ViewController *)self.presentingViewController).emailLabel.text = self.emailField.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
