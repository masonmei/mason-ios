//
//  BRDBirthdayImport.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/31/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRDBirthdayImport.h"
#import "UIImage+Thumbnail.h"

@implementation BRDBirthdayImport

-(id)initWithAddressBookRecord:(ABRecordRef)addressBookRecord{
    self = [super init];
    if(self){
        CFStringRef firstName = nil;
        CFStringRef lastName = nil;
        ABRecordID recordID;
        CFDateRef birthdate = nil;
        NSString *name = @"";
        
        recordID = ABRecordGetRecordID(addressBookRecord);
        firstName = ABRecordCopyValue(addressBookRecord, kABPersonFirstNameProperty);
        lastName = ABRecordCopyValue(addressBookRecord, kABPersonLastNameProperty);
        birthdate = ABRecordCopyValue(addressBookRecord, kABPersonBirthdayProperty);
        
        if(firstName != nil){
            name = [name stringByAppendingString:(__bridge NSString *) firstName];
            if(lastName != nil){
                name = [name stringByAppendingFormat:@" %@", lastName];
            }
        } else if(lastName != nil){
            name = (__bridge NSString *)lastName;
        }
        
        self.name = name;
        
        self.uid = [NSString stringWithFormat:@"ab-%d", recordID];
        self.addressBookID = [NSNumber numberWithInt:recordID];
        
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:(__bridge NSDate *)birthdate];
        self.birthDay = @(dateComponents.day);
        self.birthMonth = @(dateComponents.month);
        self.birthYear = @(dateComponents.year);
        
        [self updateBirthdayAndAge];
        
        if([self.birthdayTextToDisplay intValue] > 150){
            self.birthYear = [NSNumber numberWithInt:0];
            self.nextBirthdayAge = [NSNumber numberWithInt:0];
        }
        
        if(ABPersonHasImageData(addressBookRecord)){
            CFDataRef imageData = ABPersonCopyImageData(addressBookRecord);
            UIImage *fullSizeImage = [UIImage imageWithData:(__bridge NSData *)imageData];
            CGFloat side = 71.f;
            side *= [[UIScreen mainScreen] scale];
            
            UIImage *thumbnail = [fullSizeImage createThumbnailToFillSize:CGSizeMake(side, side)];
            self.imageData = UIImageJPEGRepresentation(thumbnail, 1.f);
            CFRelease(imageData);
        }
        
        if(firstName){
            CFRelease(firstName);
        }
        
        if(lastName){
            CFRelease(lastName);
        }
        
        if(birthdate){
            CFRelease(birthdate);
        }
    }
    
    return self;
}

-(id)initWithFacebookDictionary:(NSDictionary *)facebookDictionary{
    self = [super init];
    if(self){
        self.name = [facebookDictionary objectForKey:@"name"];
        self.uid = [NSString stringWithFormat:@"fb-%@", facebookDictionary[@"id"]];
        self.facebookID = [NSString stringWithFormat:@"%@", facebookDictionary[@"id"]];
        
        self.picURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", self.facebookID];
        
        NSString *birthDateString = [facebookDictionary objectForKey:@"birthday"];
        NSArray *birthdaySegments = [birthDateString componentsSeparatedByString:@"/"];
        self.birthDay = [NSNumber numberWithInt:[birthdaySegments[1] intValue]];
        self.birthMonth = [NSNumber numberWithInt:[birthdaySegments[0] intValue]];
        if([birthdaySegments count] > 2){
            self.birthYear = [NSNumber numberWithInt:[birthdaySegments[2] intValue]];
        }
        [self updateBirthdayAndAge];
    }
    return self;
}

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
