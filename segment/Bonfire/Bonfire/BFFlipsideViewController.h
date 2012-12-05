//
//  BFFlipsideViewController.h
//  Bonfire
//
//  Created by Mason Mei on 12/1/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFFlipsideViewController;

@protocol BFFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(BFFlipsideViewController *)controller;
@end

@interface BFFlipsideViewController : UIViewController

@property (weak, nonatomic) id <BFFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
