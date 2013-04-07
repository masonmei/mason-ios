//
//  BRNotificationTimeViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/26/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRNotificationTimeViewController.h"
#import "BRStyleSheet.h"
#import "BRDSettings.h"

@interface BRNotificationTimeViewController ()

@end

@implementation BRNotificationTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [BRStyleSheet styleLabel:self.whatTimeLabel withType:BRLabelTypeLarge];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    int hour = [BRDSettings sharedInstance].notificationHour;
    int min = [BRDSettings sharedInstance].notificationMinute;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:[NSDate date]];
    components.hour = hour;
    components.minute = min;
    self.timePicker.date = [[NSCalendar currentCalendar] dateFromComponents:components];
}

-(void)didChangeTime:(id)sender {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self.timePicker.date];
    NSLog(@"Changed time to %d:%d", components.hour, components.minute);
    
    [BRDSettings sharedInstance].notificationHour = components.hour;
    [BRDSettings sharedInstance].notificationMinute = components.minute;
}

@end
