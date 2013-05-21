//
//  HGGirlViewControllerDelegate.h
//  HelloGirl
//
//  Created by Mason Mei on 4/8/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGGirlViewController;

@protocol HGGirlViewControllerDelegate <NSObject>

@required
-(void)girl:(HGGirlViewController *)view saysIAmHere:(BOOL)bIsHere;

@end
