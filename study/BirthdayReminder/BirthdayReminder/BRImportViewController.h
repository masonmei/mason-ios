//
//  BRImportViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/30/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRImportViewController : BRCoreViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *birthdays;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *importButton;

- (IBAction)didTapImportButton:(id)sender;
- (IBAction)didTapSelectAllButton:(id)sender;
- (IBAction)didTapSelectNoneButton:(id)sender;

@end
