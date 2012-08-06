//
//  ViewController.h
//  FlowerWeb
//
//  Created by Mason Mei on 8/6/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *colorChoice;
@property (strong, nonatomic) IBOutlet UIWebView *flowerView;
@property (strong, nonatomic) IBOutlet UIWebView *flowerDetailView;

- (IBAction)toggleFlowerDetail:(id)sender;
- (IBAction)getFlower:(id)sender;
@end
