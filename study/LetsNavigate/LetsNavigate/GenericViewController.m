//
//  GenericViewController.m
//  LetsNavigate
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()

@end

@implementation GenericViewController
@synthesize countLabel;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCountLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)incrementCount:(id)sender {
    ((CountingNavigationController *)self.parentViewController).pushCount++;
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *pushText;
    pushText = [[NSString alloc] initWithFormat:@"%d", ((CountingNavigationController *)self.parentViewController).pushCount];
    self.countLabel.text = pushText;
}
@end
