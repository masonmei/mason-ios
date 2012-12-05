//
//  BFFlipsideViewController.m
//  Bonfire
//
//  Created by Mason Mei on 12/1/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "BFFlipsideViewController.h"

@interface BFFlipsideViewController ()

@end

@implementation BFFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
