//
//  BRSettingsViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface BRSettingsViewController : UITableViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellDaysBefore;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellNotificationTime;

- (IBAction)didClickDoneButton:(id)sender;
@end
