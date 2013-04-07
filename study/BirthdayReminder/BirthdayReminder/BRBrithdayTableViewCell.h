//
//  BRBrithdayTableViewCell.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/29/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRDBirthday;
@class BRDBirthdayImport;

@interface BRBrithdayTableViewCell : UITableViewCell
@property (nonatomic, strong) BRDBirthday *birthday;
@property (nonatomic, strong) BRDBirthdayImport *birthdayImport;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *remainingDaysImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingDaysSubTextLabel;


@end
