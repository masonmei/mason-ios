//
//  BRImportAddressBookViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/30/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRImportAddressBookViewController.h"
#import "BRDModel.h"

@interface BRImportAddressBookViewController ()

@end

@implementation BRImportAddressBookViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddressBookBirthdayDidUpdate:) name:BRNotificationAddressBookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
    [[BRDModel sharedInstance] fetchAddressBookBirthdays];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRNotificationAddressBookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
}

-(void) handleAddressBookBirthdayDidUpdate:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    self.birthdays = [userInfo objectForKey:@"birthdays"];
    [self.tableView reloadData];
    
    if([self.birthdays count] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry, no birthdays found in your address book" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}
@end
