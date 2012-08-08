//
//  GenericViewController.m
//  LetsTab
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()

@end

@implementation GenericViewController
@synthesize outputLabel;
@synthesize barItem;

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
    [self setOutputLabel:nil];
    [self setBarItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)updateCounts{
    NSString *countString;
    countString = [[NSString alloc] initWithFormat:@"First: %d\nSecond: %d\nThird:%d", ((CountingTabBarControllerViewController *)self.parentViewController).firstCount, ((CountingTabBarControllerViewController *)self.parentViewController).secondCount, ((CountingTabBarControllerViewController *)self.parentViewController).thirdCount];
    self.outputLabel.text = countString;
}

-(void)updateBadge{
    NSString *badgeCount;
    int currentBadge;
    currentBadge = [self.barItem.badgeValue intValue];
    currentBadge++;
    badgeCount = [[NSString alloc] initWithFormat:@"%d", currentBadge];
    self.barItem.badgeValue = badgeCount;
}

- (IBAction)incrementCountFirst:(id)sender {
    ((CountingTabBarControllerViewController *)self.parentViewController).firstCount++;
    [self updateBadge];
    [self updateCounts];
}

- (IBAction)incrementCountSecond:(id)sender {
    ((CountingTabBarControllerViewController *)self.parentViewController).secondCount++;
    [self updateBadge];
    [self updateCounts];
}

- (IBAction)incrementCountThird:(id)sender {
    ((CountingTabBarControllerViewController *)self.parentViewController).thirdCount++;
    [self updateBadge];
    [self updateCounts];
}

-(void)viewWillAppear:(BOOL)animated{
    [self updateCounts];
}
@end
