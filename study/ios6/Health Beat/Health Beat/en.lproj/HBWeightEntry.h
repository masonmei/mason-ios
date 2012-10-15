//
//  HBWeightEntry.h
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LBS,
    KG
} WeightUnit;

@interface HBWeightEntry : NSObject

@property(nonatomic, assign, readonly) CGFloat weightInLbs;
@property(nonatomic, strong, readonly) NSDate* date;

+ (CGFloat)convertLbsToKg:(CGFloat)lbs;
+ (CGFloat)convertKgToLbs:(CGFloat)kg;

+ (NSString*)stringForUnit:(WeightUnit)unit;
+ (NSString*)stringForWeight:(CGFloat)weight ofUnit:(WeightUnit)unit;
+ (NSString*)stringForWeightInLbs:(CGFloat)weight inUnit:(WeightUnit)unit;

-(id) initWithWeight:(CGFloat)weight usingUnits:(WeightUnit)unit forDate:(NSDate*)date;
- (CGFloat)weightInUnit:(WeightUnit)unit;
- (NSString*)stringForWeightInUnit:(WeightUnit)unit;
@end
