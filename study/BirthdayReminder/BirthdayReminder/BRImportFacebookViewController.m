//
//  BRImportFacebookViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 4/1/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRImportFacebookViewController.h"
#import "BRDModel.h"

@interface BRImportFacebookViewController ()

@end

@implementation BRImportFacebookViewController


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFacebookBirthdaysDidUpdate:) name:BRNotificationFacebookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
    [[BRDModel sharedInstance] fetchFacebookBirthdays];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRNotificationFacebookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
}

-(void) handleFacebookBirthdaysDidUpdate:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    self.birthdays = userInfo[@"birthdays"];
    [self.tableView reloadData];
}

@end
