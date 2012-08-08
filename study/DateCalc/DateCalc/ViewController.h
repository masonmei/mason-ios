//
//  ViewController.h
//  DateCalc
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateChooserViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;
@property (nonatomic) Boolean dateChooserVisible;

- (IBAction)showDateChooser:(id)sender;
-(void) calculateDateDifference:(NSDate *) chosenDate;
@end
