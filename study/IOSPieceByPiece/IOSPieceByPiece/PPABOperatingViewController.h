//
//  PPABOperatingViewController.h
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/20/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface PPABOperatingViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *contactTableView;

- (IBAction)addContact:(id)sender;

@end
