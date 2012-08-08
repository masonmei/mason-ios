//
//  DateChooserViewController.h
//  DateCalc
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DateChooserViewController : UIViewController 
@property (strong, nonatomic) id delegate;
- (IBAction)setDateTime:(id)sender;
- (IBAction)dismissDateChooser:(id)sender;

@end
