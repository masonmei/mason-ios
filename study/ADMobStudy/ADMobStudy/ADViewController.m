//
//  ADViewController.m
//  ADMobStudy
//
//  Created by masonmei on 1/16/13.
//  Copyright (c) 2013 personal.org. All rights reserved.
//

#import "ADViewController.h"
#import "Constants.h"

@interface ADViewController ()

@end

@implementation ADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView.adUnitID = MY_BANNER_UNIT_ID;
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    GADRequest *request = [GADRequest request];
    request.testing = YES;
    [bannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
