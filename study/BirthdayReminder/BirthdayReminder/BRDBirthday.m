//
//  BRDBirthday.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/27/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRDBirthday.h"


@implementation BRDBirthday

@dynamic birthDay;
@dynamic birthMonth;
@dynamic birthYear;
@dynamic facebookID;
@dynamic imageData;
@dynamic addressBookID;
@dynamic name;
@dynamic nextBirthday;
@dynamic nextBirthdayAge;
@dynamic note;
@dynamic picURL;
@dynamic uid;

-(void)updateBirthdayAndAge{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    
    NSDate *today = [calendar dateFromComponents:dateComponents];
    dateComponents.day = [self.birthDay intValue];
    dateComponents.month = [self.birthMonth intValue];
    
    NSDate *birthdayThisYear = [calendar dateFromComponents:dateComponents];
    if([today compare:birthdayThisYear] == NSOrderedDescending){
        dateComponents.year++;
        self.nextBirthday = [calendar dateFromComponents:dateComponents];
    }else{
        self.nextBirthday = [birthdayThisYear copy];
    }
    
    if([self.birthYear intValue] > 0){
        self.nextBirthdayAge = [NSNumber numberWithInt:dateComponents.year - [self.birthYear intValue]];
    }else{
        self.nextBirthdayAge = [NSNumber numberWithInt:0];
    }
}

-(void)updateWithDefaults{
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    self.birthDay = @(dateComponent.day);
    self.birthMonth = @(dateComponent.month);
    self.birthYear = @0;
    [self updateBirthdayAndAge];
}

-(int)remainingDaysUntilNextBirthday{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToday = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:componentsToday];
    NSTimeInterval timeDiffSecs = [self.nextBirthday timeIntervalSinceDate:today];
    int days = floor(timeDiffSecs/(60.0f * 60.0f * 24.0f));
    return days;
}

-(BOOL)isBirthdayToday{
    return [self remainingDaysUntilNextBirthday] == 0;
}

-(NSString *)birthdayTextToDisplay{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToday = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:componentsToday];
    
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:today toDate:self.nextBirthday options:0];
    
    if(components.month ==0){
        if(components.day == 0){
            if([self.nextBirthdayAge intValue] > 0){
                return [NSString stringWithFormat:@"%@ Today!", self.nextBirthdayAge];
            }else{
                return @"Today";
            }
        }
        
        if(components.day == 1){
            if([self.nextBirthdayAge intValue] > 0){
                return [NSString stringWithFormat:@"%@ Tomorrow!", self.nextBirthdayAge];
            }else{
                return @"Tomorrow";
            }
        }
    }
    
    NSString *text = @"";
    if([self.nextBirthdayAge intValue] > 0){
        text = [NSString stringWithFormat:@"%@ on ", self.nextBirthdayAge];
    }
    
    static NSDateFormatter *dateFormatter;
    
    if(dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MMM d"];
    }
    return [text stringByAppendingFormat:@"%@", [dateFormatter stringFromDate:self.nextBirthday]];
}

@end
