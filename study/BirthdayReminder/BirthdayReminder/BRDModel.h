//
//  BRModel.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/27/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BRNotificationAddressBookBirthdaysDidUpdate @"BRNotificationAddressBookBirthdaysDidUpdate"
#define BRNotificationFacebookBirthdaysDidUpdate @"BRNotificationFacebookBirthdaysDidUpdate"
#define BRNotificationCachedBirthdaysDidUpdate @"BRNotificationCachedBirthdaysDidUpdate"

@interface BRDModel : NSObject
+(BRDModel *)sharedInstance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) cancelChanges;
-(void) saveChanges;
-(void) importBirthdays:(NSArray *)birthdaysToImport;
-(void) fetchAddressBookBirthdays;
-(void) fetchFacebookBirthdays;

-(void) updateCachedBirthdays;

-(NSMutableDictionary *) getExistingBirthdaysWithUIDs:(NSArray *)uids;

-(void) postToFacebook:(NSString *)msg withFacebookId:(NSString *)facebookId;
@end
