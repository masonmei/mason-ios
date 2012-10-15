//
//  HBEnterWeightViewController.h
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBWeightHistory;

@interface HBEnterWeightViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) HBWeightHistory* weightHistory;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) UIButton* unitsButton;

- (IBAction)saveWeight:(id)sender;
- (IBAction)changeUnits:(id)sender;
@end
