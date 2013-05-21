//
//  HGGirlViewController.m
//  HelloGirl
//
//  Created by Mason Mei on 4/8/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "HGGirlViewController.h"

@interface HGGirlViewController ()
{
    BOOL m_bIsGirlSeen;
}

@end

@implementation HGGirlViewController
@synthesize delegate;
@synthesize lblMsgForGirl;
@synthesize msgForGirl;

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    m_bIsGirlSeen = NO;
    self.lblMsgForGirl.text = self.msgForGirl;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.delegate girl:self saysIAmHere:m_bIsGirlSeen];
}

- (IBAction)onSwitchValueChanged:(id)sender {
    UISwitch *theSwitch = (UISwitch *)sender;
    m_bIsGirlSeen = theSwitch.isOn;
}
@end
