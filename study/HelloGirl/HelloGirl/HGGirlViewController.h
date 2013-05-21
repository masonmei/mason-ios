//
//  HGGirlViewController.h
//  HelloGirl
//
//  Created by Mason Mei on 4/8/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGGirlViewControllerDelegate.h"

@protocol HGGirlViewControllerDelegate;

@interface HGGirlViewController : UIViewController

@property (weak, atomic) id<HGGirlViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblMsgForGirl;
@property (strong, nonatomic) NSString *msgForGirl;

- (IBAction)onSwitchValueChanged:(id)sender;
@end
