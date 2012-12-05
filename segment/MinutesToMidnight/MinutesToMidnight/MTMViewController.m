//
//  MTMViewController.m
//  MinutesToMidnight
//
//  Created by Mason Mei on 11/29/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "MTMViewController.h"

@interface MTMViewController (){
    int count;
}

@end

@implementation MTMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    count = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void)updateLabel{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit) fromDate:date];
    int hour = 23 - [components hour];
    int min = 59 - [components minute];
    int sec = 59 - [components second];
    self.countdownLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, min, sec];
//    self.countdownLabel.text = [NSString stringWithFormat:@"%2d", count];
    count ++;
}

-(void)onTimer{
    [self updateLabel];
}
@end
