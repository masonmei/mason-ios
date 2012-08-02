//
//  HelloWorldViewController.h
//  SimpleEmail
//
//  Created by Mason Mei on 7/30/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelloWorldViewController : UIViewController <MFMailComposeViewControllerDelegate>
- (IBAction)showEmail:(id)sender;

@end
