//
//  BRHomeViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"
#import "BRBlueButton.h"

@interface BRHomeViewController : BRCoreViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *importLabel;
@property (weak, nonatomic) IBOutlet BRBlueButton *addressBookButton;
@property (weak, nonatomic) IBOutlet BRBlueButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIView *importView;

- (IBAction)importFromAddressBookTapped:(id)sender;
- (IBAction)importFromFacebookTapped:(id)sender;
@end
