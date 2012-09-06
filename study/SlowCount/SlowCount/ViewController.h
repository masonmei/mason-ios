//
//  ViewController.h
//  SlowCount
//
//  Created by Mason Mei on 9/6/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int count;
    UIBackgroundTaskIdentifier counterTask;
}
@property (strong, nonatomic) IBOutlet UILabel *theCount;
@property (strong, nonatomic) NSTimer *theTimer;

-(void)countUp;
@end
