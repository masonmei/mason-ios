//
//  MTMViewController.h
//  MinutesToMidnight
//
//  Created by Mason Mei on 11/29/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMViewController : UIViewController{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

-(void) updateLabel;
-(void) onTimer;
@end
