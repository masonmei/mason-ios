//
//  BRDSettings.h
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BRDBirthday;

typedef enum : int{
    BRDaysBeforeTypeOnBirthday = 0,
    BRDaysBeforeTypeOneDay,
    BRDaysBeforeTypeTwoDays,
    BRDaysBeforeTypeThreeDays,
    BRDaysBeforeTypeFiveDays,
    BRDaysBeforeTypeOneWeek,
    BRDaysBeforeTypeTwoWeeks,
    BRDaysBeforeTypeThreeWeeks
}BRDaysBeforeType;

@interface BRDSettings : NSObject

+(BRDSettings *) sharedInstance;

@property (nonatomic) int notificationHour;
@property (nonatomic) int notificationMinute;
@property (nonatomic) BRDaysBeforeType daysBefore;

-(NSString *) titleForNotificationTime;
-(NSString *) titleForDaysBefore:(BRDaysBeforeType) daysBefore;

-(NSDate *) reminderDateForNextBirthday:(NSDate *)nextBirthday;
-(NSString *) reminderTextForNextBirthday:(BRDBirthday *)birthday;

@end
