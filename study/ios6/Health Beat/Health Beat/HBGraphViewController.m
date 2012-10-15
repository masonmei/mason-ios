//
//  HBGraphViewController.m
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "HBGraphViewController.h"
#import "HBWeightHistory.h"

@interface HBGraphViewController ()

@end

@implementation HBGraphViewController
@synthesize weightHistory = _weightHistory;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
