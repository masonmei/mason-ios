//
//  HBEnterWeightViewController.m
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "HBEnterWeightViewController.h"
#import "HBWeightHistory.h"

@interface HBEnterWeightViewController ()

@end

@implementation HBEnterWeightViewController
@synthesize weightHistory = _weightHistory;
@synthesize unitsButton = _unitsButton;

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
    self.unitsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unitsButton.frame = CGRectMake(0.0f, 0.0f, 25.0f, 17.0f);
    self.unitsButton.backgroundColor = [UIColor lightGrayColor];
    self.unitsButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.unitsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.unitsButton setTitle:@"lbs" forState:UIControlStateNormal];
    [self.unitsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.unitsButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.unitsButton addTarget:self action:@selector(changeUnits:) forControlEvents:UIControlEventTouchUpInside];
    self.weightTextField.rightView = self.unitsButton;
    self.weightTextField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (IBAction)saveWeight:(id)sender {
}

@end
