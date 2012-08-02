//
//  ViewController.h
//  HelloNoun
//
//  Created by Mason Mei on 8/2/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *userOutput;
@property (strong, nonatomic) IBOutlet UITextField * userInput;

-(IBAction) setOutput:(id)sender;

@end
