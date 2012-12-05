//
//  CTAppDelegate.m
//  CustomTabApp
//
//  Created by Mason Mei on 12/4/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "CTAppDelegate.h"

@implementation CTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabBar.items objectAtIndex:3];
    
    item1.title = @"Home";
    item2.title = @"Maps";
    item3.title = @"My Plan";
    item4.title = @"Settings";
    
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"home_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"maps_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"maps.png"]];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"myplan_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"myplan.png"]];
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"settings_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"settings.png"]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:backgroundImage];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateHighlighted];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end