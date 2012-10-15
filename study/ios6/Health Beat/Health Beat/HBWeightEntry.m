//
//  HBWeightEntry.m
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "HBWeightEntry.h"

static const CGFloat LBS_PER_KG = 2.20462262f;
static NSNumberFormatter* formatter;

@implementation HBWeightEntry
@synthesize weightInLbs = _weightInLbs;
@synthesize date = _date;

-(id)initWithWeight:(CGFloat)weight usingUnits:(WeightUnit)unit forDate:(NSDate *)date{
    self = [super init];
    if(self){
        if(unit == LBS){
            _weightInLbs = weight;
        } else {
            _weightInLbs = [HBWeightEntry convertKgToLbs:weight];
        }
        _date = date;
    }
    return self;
}

-(id)init{
    NSDate* referenceDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
    return [self initWithWeight:0.0f usingUnits:LBS forDate:referenceDate];
}

+(void)initialize{
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimum:[NSNumber numberWithFloat:0.0f]];
    [formatter setMaximumFractionDigits:2];
}

+(CGFloat)convertKgToLbs:(CGFloat)kg{
    return kg * LBS_PER_KG;
}

+(CGFloat)convertLbsToKg:(CGFloat)lbs{
    return lbs / LBS_PER_KG;
}

+(NSString *)stringForUnit:(WeightUnit)unit{
    switch (unit) {
        case KG:
            return @"kg";
        case LBS:
            return @"lbs";
        default:
            [NSException raise:NSInvalidArgumentException format:@"The value %d is not a valid WeightUnit", unit];
    }
    return @"";
}

+(NSString *)stringForWeight:(CGFloat)weight ofUnit:(WeightUnit)unit{
    NSString* weightString = [formatter stringFromNumber:[NSNumber numberWithFloat:weight]];
    NSString* unitString = [HBWeightEntry stringForUnit:unit];
    return [NSString stringWithFormat:@"%@ %@", weightString, unitString];
}

+(NSString *)stringForWeightInLbs:(CGFloat)weight inUnit:(WeightUnit)unit{
    CGFloat convertedWeight;
    switch (unit) {
        case LBS:
            convertedWeight = weight;
            break;
        case KG:
            convertedWeight = [HBWeightEntry convertLbsToKg:weight];
            break;
        default:
            [NSException raise:NSInvalidArgumentException format:@"%d is not a valid WeightUnit", unit];
    }
    return [HBWeightEntry stringForWeight:convertedWeight ofUnit:unit];
}
-(CGFloat)weightInUnit:(WeightUnit)unit{
    switch (unit) {
        case LBS:
            return self.weightInLbs;
        case KG:
            return [HBWeightEntry convertLbsToKg:self.weightInLbs];
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"The value %d is not a valid WeightUnit.", unit];
    }
    
    return 0.0f;
}

-(NSString *)stringForWeightInUnit:(WeightUnit)unit{
    return [HBWeightEntry stringForWeight:[self weightInUnit:unit] ofUnit:unit];
}
@end
