//
//  HBWeightHistory.h
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBWeightEntry.h"

static NSString* const WeightHistoryChangedDefaultUnitsNotification = @"WeightHistory changed the default units";
static NSString* const KVOWeightChangeKey = @"weightHistory";

@interface HBWeightHistory : NSObject
@property (nonatomic, readonly) NSArray* weights;
@property (nonatomic, assign, readwrite) WeightUnit defaultUnits;

- (void)addWeight:(HBWeightEntry*)weight;
- (void)removeWeightAtIndex:(NSUInteger)index;
@end
