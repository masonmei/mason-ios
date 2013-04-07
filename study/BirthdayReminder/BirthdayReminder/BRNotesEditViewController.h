//
//  BRNotesEditViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"
@class BRDBirthday;

@interface BRNotesEditViewController : BRCoreViewController<UITextViewDelegate>
@property (strong, nonatomic) BRDBirthday *birthday;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
