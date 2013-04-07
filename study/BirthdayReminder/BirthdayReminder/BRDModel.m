//
//  BRModel.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/27/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRDModel.h"
#import "BRDBirthday.h"
#import <AddressBook/AddressBook.h>
#import "BRDBirthdayImport.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "BRDSettings.h"

typedef enum : int{
    FacebookActionGetFriendsBirthdays = 1,
    FacebookActionPostToWall
}FacebookAction;

@interface BRDModel()

@property (strong) ACAccount *facebookAccount;
@property FacebookAction currentFacebookAction;
@property (nonatomic, strong) NSString *postToFacebookMsg;
@property (nonatomic, strong) NSString *postToFacebookId;

@end

@implementation BRDModel

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static BRDModel *_sharedInstance = nil;
+ (BRDModel *)sharedInstance{
    if(!_sharedInstance){
        _sharedInstance = [[BRDModel alloc]init];
    }
    return _sharedInstance;
}

-(NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext != nil){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

-(NSManagedObjectModel *)managedObjectModel{
    if(_managedObjectModel != nil){
        return _managedObjectModel;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"BirthdayReminder" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentDirectory] URLByAppendingPathComponent:@"BirthdayReminder.sqlite"];
    NSError * error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

-(NSURL *)applicationDocumentDirectory {
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)cancelChanges{
    [self.managedObjectContext rollback];
}

-(void)saveChanges{
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges]) {
        if(![self.managedObjectContext save:&error]){
            NSLog(@"Save failed: %@", [error localizedDescription]);
        } else{
            NSLog(@"Save succeeded");
        }
    }
}

-(void)importBirthdays:(NSArray *)birthdaysToImport{
    int i;
    int max = [birthdaysToImport count];
    BRDBirthday *importBirthday;
    BRDBirthday *birthday;
    
    NSString *uid;
    NSMutableArray *newUIDs = [NSMutableArray array];
    
    for (i = 0; i < max; i++) {
        importBirthday = birthdaysToImport[i];
        uid = importBirthday.uid;
        [newUIDs addObject:uid];
    }
    
    NSMutableDictionary *existingBirthdays = [self getExistingBirthdaysWithUIDs:newUIDs];
    
    NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
    
    for (i = 0; i < max; i++) {
        importBirthday = birthdaysToImport[i];
        uid = importBirthday.uid;
        
        birthday = existingBirthdays[uid];
        
        if(birthday){
            //
        }else{
            birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
            birthday.uid = uid;
            existingBirthdays[uid] = birthday;
        }
        
        birthday.name = importBirthday.name;
        birthday.uid = importBirthday.uid;
        birthday.picURL = importBirthday.picURL;
        birthday.imageData = importBirthday.imageData;
        birthday.addressBookID = importBirthday.addressBookID;
        birthday.facebookID = importBirthday.facebookID;
        birthday.birthDay = importBirthday.birthDay;
        birthday.birthMonth = importBirthday.birthMonth;
        birthday.birthYear = importBirthday.birthYear;
        
        [birthday updateBirthdayAndAge];
    }
    [self saveChanges];
}

-(void)fetchAddressBookBirthdays{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            NSLog(@"User has already granted access to the address book");
            [self extractBirthdaysFromAddressBook:addressBook];
            break;
        case kABAuthorizationStatusRestricted:
            NSLog(@"User has restricted access to Address book possibly due to parental controls");
            break;
        case kABAuthorizationStatusDenied:
            NSLog(@"User has denied access to the Address Book");
            break;
        case kABAuthorizationStatusNotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
                if (granted) {
                    NSLog(@"Access to Address Book has been granted");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self extractBirthdaysFromAddressBook:ABAddressBookCreateWithOptions(NULL, NULL)];
                         });
                }else {
                    NSLog(@"Access to the Address Book has been denied");
                }
            });
            break;
    }
    CFRelease(addressBook);
}

-(void)fetchFacebookBirthdays{
    NSLog(@"fetchFacebookBirthdays");
    if(_facebookAccount == nil){
        _currentFacebookAction = FacebookActionGetFriendsBirthdays;
        [self authenticateWithFacebook];
        return;
    }
    
    NSURL *requestUrl = [NSURL URLWithString:@"https://graph.facebook.com/me/friends"];
    NSDictionary *params = @{@"fields": @"name,id,birthday"};
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:requestUrl parameters:params];
    
    request.account = _facebookAccount;
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error != nil){
            NSLog(@"Error getting my Facebook friend birthdays: %@", error);
        } else {
            NSDictionary *result = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            
            NSArray *birthdayDictionaries = result[@"data"];
            int birthdayCount = [birthdayDictionaries count];
            
            NSDictionary *facebookDictionary;
            
            NSMutableArray * birthdays = [NSMutableArray array];
            BRDBirthdayImport *birthday;
            NSString *birthDateS;
            
            for (int i = 0; i < birthdayCount; i++) {
                facebookDictionary = birthdayDictionaries[i];
                birthDateS = facebookDictionary[@"birthday"];
                if(!birthDateS){
                    continue;
                }
                
                NSLog(@"Find a Facebook Birthday: %@", facebookDictionary);
                birthday = [[BRDBirthdayImport alloc] initWithFacebookDictionary:facebookDictionary];
                [birthdays addObject:birthday];
            }
            
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
            [birthdays sortUsingDescriptors:sortDescriptors];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *userInfo = @{@"birthdays": birthdays};
                [[NSNotificationCenter defaultCenter] postNotificationName:BRNotificationFacebookBirthdaysDidUpdate object:self userInfo:userInfo];
            });
            
            NSLog(@"Facebook returned friends: %@", result);
        }
    }];
    
}

-(NSMutableDictionary *)getExistingBirthdaysWithUIDs:(NSArray *)uids{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSManagedObjectContext *context = self.managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid IN %@", uids];
    request.predicate = predicate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
    request.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"uid" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    if(![fetchedResultsController performFetch:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSArray *fetchedObjects = fetchedResultsController.fetchedObjects;
    NSInteger resultCount = [fetchedObjects count];
    if(resultCount == 0){
        return [NSMutableDictionary dictionary];
    }
    
    BRDBirthday *birthday;
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    int i;
    for(i = 0; i < resultCount; i++){
        birthday = fetchedObjects[i];
        tmpDict[birthday.uid] = birthday;
    }
    return  tmpDict;
}

-(void) extractBirthdaysFromAddressBook:(ABAddressBookRef) addressBook{
    NSLog(@"extractBirthdaysFromAddressBook");
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex peopleCount = ABAddressBookGetPersonCount(addressBook);
    
    BRDBirthdayImport *birthday;
    
    NSMutableArray *birthdays = [NSMutableArray array];
    for (int i = 0; i < peopleCount; i++) {
        ABRecordRef addressBookRecord = CFArrayGetValueAtIndex(people, i);
        CFDataRef birthDate = ABRecordCopyValue(addressBookRecord, kABPersonBirthdayProperty);
        if(birthDate == nil){
            continue;
        }
        
        CFStringRef firstName = ABRecordCopyValue(addressBookRecord, kABPersonFirstNameProperty);
        if(firstName == nil){
            CFRelease(birthDate);
            continue;
        }
        
        birthday = [[BRDBirthdayImport alloc] initWithAddressBookRecord:addressBookRecord];
        [birthdays addObject:birthday];
        
        NSLog(@"Found contact with birthday: %@, %@", firstName, birthDate);
        CFRelease(firstName);
        CFRelease(birthDate);
    }
    CFRelease(people);
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [birthdays sortUsingDescriptors:sortDescriptors];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:birthdays, @"birthdays", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:BRNotificationAddressBookBirthdaysDidUpdate object:self userInfo:userInfo];
}

-(void) authenticateWithFacebook{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountTypeFacebook = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSArray *permissions = [NSArray arrayWithObjects:@"friends_birthday", nil];
    
    NSDictionary *options = @{ACFacebookAppIdKey: @"561988173822866",
                              ACFacebookPermissionsKey: permissions,
                              ACFacebookAudienceKey: ACFacebookAudienceFriends};
    
    
    
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook options:options completion:^(BOOL granted, NSError *error) {
        if(granted){
            NSLog(@"Facebook Authorized!");
            NSArray *accounts = [accountStore accountsWithAccountType:accountTypeFacebook];
            _facebookAccount = [accounts lastObject];
            
            switch (_currentFacebookAction) {
                case FacebookActionGetFriendsBirthdays:
                    [self fetchFacebookBirthdays];
                    break;
                case FacebookActionPostToWall:
                    [self postToFacebook:self.postToFacebookMsg withFacebookId:self.postToFacebookId];
                    break;
            }
        } else {
            if ([error code] == ACErrorAccountNotFound){
                NSLog(@"No facebook Account Found");
            } else {
                NSLog(@"Facebook SSO Authenticatioin Failed: %@", error);
            }
        }
    }];
}

-(void)postToFacebook:(NSString *)msg withFacebookId:(NSString *)facebookId{
    NSLog(@"postToFacebook");
    
    if(self.facebookAccount == nil){
        self.postToFacebookMsg = msg;
        self.postToFacebookId = facebookId;
        self.currentFacebookAction = FacebookActionPostToWall;
        [self authenticateWithFacebook];
        return;
    }
    NSLog(@"We're authorized so post to Facebook!");
    NSDictionary *params = @{@"message": msg};
    NSString *postGraphPath = [NSString stringWithFormat:@"https://graph.facebook.com/%@/feed", facebookId];
    NSURL *requestUrl = [NSURL URLWithString:postGraphPath];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodPOST URL:requestUrl parameters:params];
    request.account = self.facebookAccount;
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error != nil){
            NSLog(@"Error Posting to Facebook: %@", error);
        } else {
            NSDictionary *dict = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            NSLog(@"Successfully posted to Facebook! Post ID: %@", dict);
        }
    }];
}

-(void)updateCachedBirthdays{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
    fetchRequest.entity = entity;
    //Fetch all the birthday entities in order of next birthday
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nextBirthday" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSArray *fetchedObjects = fetchedResultsController.fetchedObjects;
    NSInteger resultCount = [fetchedObjects count];
    
    NSDate *now = [NSDate date];
    NSDateComponents *dateComponentsToday = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    //This creates a date with time 00:00 today
    NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:dateComponentsToday];
    
    UILocalNotification *reminderNotification;
    int scheduled = 0;
    NSDate *fireDate;
    
    for (int i = 0; i < resultCount; i++) {
        BRDBirthday *birth = (BRDBirthday *) fetchedObjects[i];
        if ([today compare:birth.nextBirthday] == NSOrderedDescending) {
            [birth updateBirthdayAndAge];
        }
        
        if(scheduled < 20){
            fireDate = [[BRDSettings sharedInstance] reminderDateForNextBirthday:birth.nextBirthday];
            if([now compare:fireDate] != NSOrderedAscending){
                
            } else {
                reminderNotification = [[UILocalNotification alloc] init];
                reminderNotification.fireDate = fireDate;
                reminderNotification.timeZone = [NSTimeZone defaultTimeZone];
                reminderNotification.alertAction = @"View Birthdays";
                reminderNotification.alertBody = [[BRDSettings sharedInstance] reminderTextForNextBirthday:birth];
                reminderNotification.soundName = @"HappyBirthday.m4a";
                reminderNotification.applicationIconBadgeNumber = 1;
                
                [[UIApplication sharedApplication] scheduledLocalNotifications];
                scheduled++;
            }
        }
    }
    [self saveChanges];
    //Let any observer's know that the birthdays in our database have been updated
    [[NSNotificationCenter defaultCenter] postNotificationName:BRNotificationCachedBirthdaysDidUpdate object:self  userInfo:nil];
}
@end
