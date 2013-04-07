//
//  BRNotificationTimeViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/26/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRNotificationTimeViewController : BRCoreViewController
@property (weak, nonatomic) IBOutlet UILabel *whatTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

-(IBAction)didChangeTime:(id)sender;
@end
