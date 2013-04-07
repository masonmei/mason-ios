//
//  BRBirthdayEditViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"
@class BRDBirthday;

@interface BRBirthdayEditViewController : BRCoreViewController<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *includeYearLabel;
@property (weak, nonatomic) IBOutlet UISwitch *includeYearSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *photoContainerView;
@property (weak, nonatomic) IBOutlet UILabel *picPhotoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) BRDBirthday *birthday;

- (IBAction)didChangeNameText:(id)sender;
- (IBAction)didToggleSwitch:(id)sender;
- (IBAction)didChangeDatePicker:(id)sender;
- (IBAction)didTapPhoto:(id)sender;
@end
