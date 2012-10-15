//
//  HBWeightHistory.m
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "HBWeightHistory.h"

@interface HBWeightHistory ()
    @property (nonatomic, strong) NSMutableArray* weightHistory;
@end

@implementation HBWeightHistory
@synthesize weightHistory = _weightHistory;
@synthesize defaultUnits = _defaultUnits;

- (id)init{
    self = [super init];
    if (self) {
        _defaultUnits = LBS;
        _weightHistory = [[NSMutableArray alloc] init];
    }
    return self;
}

+(NSSet *)keyPathsForValuesAffectingWeightHistory{
    return [NSSet setWithObjects:KVOWeightChangeKey, nil];
}

-(NSArray *)weights{
    return self.weightHistory;
}

- (void)setDefaultUnits:(WeightUnit)units {
    // If we are setting the current value, do nothing.
    if (_defaultUnits == units) return;
    _defaultUnits = units;
    // Send a notification.
    [[NSNotificationCenter defaultCenter] postNotificationName:WeightHistoryChangedDefaultUnitsNotification object:self];
}
- (void)addWeight:(HBWeightEntry*)weight {
    // Manually send KVO messages.
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:[NSIndexSet indexSetWithIndex:0] forKey:KVOWeightChangeKey];
    // Add to the front of the list.
    [self.weightHistory insertObject:weight atIndex:0];
    // Manually send KVO messages.
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:[NSIndexSet indexSetWithIndex:0] forKey:KVOWeightChangeKey];
}
// This will be auto KVO’ed.
- (void)removeWeightAtIndex:(NSUInteger)weightIndex;{
    // Manually send KVO messages.
    [self willChange:NSKeyValueChangeRemoval
     valuesAtIndexes:[NSIndexSet indexSetWithIndex:weightIndex] forKey:KVOWeightChangeKey];
    // Add to the front of the list.
    [self.weightHistory removeObjectAtIndex:weightIndex];
    // Manually send KVO messages.
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:[NSIndexSet indexSetWithIndex:weightIndex] forKey:KVOWeightChangeKey];
}

@end
