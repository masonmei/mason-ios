//
//  HGViewController.h
//  HelloGirl
//
//  Created by Mason Mei on 4/8/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGGirlViewControllerDelegate.h"

@interface HGViewController : UIViewController<HGGirlViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblFindStaus;
@property (strong, nonatomic) NSString *girlText;

@end
