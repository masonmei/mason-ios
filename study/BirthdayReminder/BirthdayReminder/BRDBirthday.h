//
//  BRDBirthday.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/27/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BRDBirthday : NSManagedObject

@property (nonatomic, retain) NSNumber * birthDay;
@property (nonatomic, retain) NSNumber * birthMonth;
@property (nonatomic, retain) NSNumber * birthYear;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSNumber * addressBookID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * nextBirthday;
@property (nonatomic, retain) NSNumber * nextBirthdayAge;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * picURL;
@property (nonatomic, retain) NSString * uid;

@property (nonatomic, readonly) int remainingDaysUntilNextBirthday;
@property (nonatomic, readonly) NSString *birthdayTextToDisplay;
@property (nonatomic, readonly) BOOL isBirthdayToday;

-(void) updateBirthdayAndAge;
-(void) updateWithDefaults;
@end
