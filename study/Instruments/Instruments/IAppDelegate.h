//
//  IAppDelegate.h
//  Instruments
//
//  Created by masonmei on 4/27/13.
//  Copyright (c) 2013 personal.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
