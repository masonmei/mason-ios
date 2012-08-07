//
//  EditorViewController.h
//  ModalEditor
//
//  Created by Mason Mei on 8/7/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface EditorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)dismissEditor:(id)sender;

@end
