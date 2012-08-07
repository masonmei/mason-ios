//
//  ViewController.h
//  PopoverEditor
//
//  Created by Mason Mei on 8/7/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditorViewController.h"

@interface ViewController : UIViewController <UIPopoverControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

@end
