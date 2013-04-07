//
//  PPAppDelegate.h
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/7/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
