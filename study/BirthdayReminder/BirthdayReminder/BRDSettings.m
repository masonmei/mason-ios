//
//  BRDSettings.m
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRDSettings.h"
#import "BRDBirthday.h"

@implementation BRDSettings

static BRDSettings *sharedInstance = nil;

static NSDateFormatter *dateFormatter;

@synthesize notificationHour;
@synthesize notificationMinute;

+(BRDSettings *)sharedInstance{
    if(!sharedInstance){
        sharedInstance = [[BRDSettings alloc] init];
    }
    return sharedInstance;
}

-(int)notificationHour{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *hour = [userDefaults objectForKey:@"notificationHour"];
    if(hour == nil){
        return 9;
    }
    return [hour intValue];
}

-(void)setNotificationHour:(int)notificationHourNew{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInt:notificationHourNew] forKey:@"notificationHour"];
    [userDefaults synchronize];
}

-(int)notificationMinute{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *min = [userDefaults objectForKey:@"notificationMinute"];
    if(min == nil){
        return 0;
    }
    return [min intValue];
}

-(void)setNotificationMinute:(int)notificationMinuteNew{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInt:notificationMinuteNew] forKey:@"notificationMinute"];
    [userDefaults synchronize];
}

-(BRDaysBeforeType)daysBefore{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *daysBefore = [userDefaults objectForKey:@"daysBefore"];
    
    if(daysBefore == nil){
        return BRDaysBeforeTypeOnBirthday;
    }
    return [daysBefore intValue];
}

-(void)setDaysBefore:(BRDaysBeforeType)daysBefore{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInt:daysBefore] forKey:@"daysBefore"];
    [userDefaults synchronize];
}

-(NSString *)titleForDaysBefore:(BRDaysBeforeType)daysBefore{
    switch (daysBefore) {
        case BRDaysBeforeTypeOnBirthday:
            return @"On Birthday";
        case BRDaysBeforeTypeOneDay:
            return @"1 Day Before";
        case BRDaysBeforeTypeTwoDays:
            return @"2 Days Before";
        case BRDaysBeforeTypeThreeDays:
            return @"3 Days Before";
        case BRDaysBeforeTypeFiveDays:
            return @"5 Days Before";
        case BRDaysBeforeTypeOneWeek:
            return @"1 Week Before";
        case BRDaysBeforeTypeTwoWeeks:
            return @"2 Weeks Before";
        case BRDaysBeforeTypeThreeWeeks:
            return @"3 Weeks Before";
    }
    return @"";
}

-(NSString *)titleForNotificationTime{
    int hour = [BRDSettings sharedInstance].notificationHour;
    int min = [BRDSettings sharedInstance].notificationMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:[NSDate date]];
    components.hour = hour;
    components.minute = min;
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    if(dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"h:mm a"];
    }
    
    return [dateFormatter stringFromDate:date];
}

-(NSDate *)reminderDateForNextBirthday:(NSDate *)nextBirthday{
    NSTimeInterval timeInterval;
    NSTimeInterval secondsInOneDay = 60 * 60 * 24.f;
    
    timeInterval = self.daysBefore * secondsInOneDay;
    
    NSDate *reminderDate = [nextBirthday dateByAddingTimeInterval:-timeInterval];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:reminderDate];
    components.hour = self.notificationHour;
    components.minute = self.notificationMinute;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

-(NSString *)reminderTextForNextBirthday:(BRDBirthday *)birthday{
    NSString *text;
    if ([birthday.nextBirthdayAge intValue] > 0) {
        if (self.daysBefore == BRDaysBeforeTypeOnBirthday) {
            //if the friend's birthday is the same day as the reminder eg. "Joe is 30 today"
            text = [NSString stringWithFormat:@"%@ is %@",birthday.name,birthday.nextBirthdayAge];
        } else {
            //reminder is in advance of the birthday eg. "Joe will be 30 tomorrow"
            text = [NSString stringWithFormat:@"%@ will be %@",birthday.name,birthday.nextBirthdayAge];
        }
    } else {
        text = [NSString stringWithFormat:@"It's %@'s Birthday ",birthday.name];
    }
    
    switch (self.daysBefore) {
        case BRDaysBeforeTypeOnBirthday:
            return [text stringByAppendingFormat:@"today!"];
        case BRDaysBeforeTypeOneDay:
            return [text stringByAppendingFormat:@"tomorrow!"];
        case BRDaysBeforeTypeTwoDays:
            return [text stringByAppendingFormat:@"in 2 days!"];
        case BRDaysBeforeTypeThreeDays:
            return [text stringByAppendingFormat:@"in 3 days!"];
        case BRDaysBeforeTypeFiveDays:
            return [text stringByAppendingFormat:@"in 5 days!"];
        case BRDaysBeforeTypeOneWeek:
            return [text stringByAppendingFormat:@"in 1 week!"];
        case BRDaysBeforeTypeTwoWeeks:
            return [text stringByAppendingFormat:@"in 2 weeks!"];
        case BRDaysBeforeTypeThreeWeeks:
            return [text stringByAppendingFormat:@"in 3 weeks!"];
    }
    return @"";
}

@end
