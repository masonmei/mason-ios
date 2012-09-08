//
//  ScramblePlayer.m
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ScramblePlayer.h"

@implementation ScramblePlayer

-(id)init{
    self = [super init];
    if(self){
        [self initializeWordList];
    }
    
    return self;
}

-(NSString *)getNextWord{
    NSString *returnString = nil;
    if([scrambleWords count] > 0){
        returnString = [scrambleWords objectAtIndex:0];
        [scrambleWords removeObjectAtIndex:0];
    }
    
    return returnString;
}

-(int)getRemainingWordCount{
    return [scrambleWords count];
}

-(void)initializeWordList{
    NSArray * masterWordList = [NSArray arrayWithObjects:@"well", @"coin", @"address", @"novel",
                                @"mat", @"panther", @"chip", @"jump", @"scream",@"spring", @"toothpick", @"shampoo", @"value", @"buoy", @"skirt", @"general", @"ink", @"engineer", @"epidemic", @"parasite", @"menu", @"clay", @"sunglasses", @"ridge",@"noun",@"mill", @"antique",@"gang",@"planet",@"headline", @"ketchup",@"passion",@"queue",@"word",@"band", @"thief",@"mustard",@"seat",@"sofa", @"queue",@"flamenco",@"comet",@"pebble", @"herald",@"factory",@"stew",@"loop", @"velcro",@"thermostat",@"loaf",@"leaf", @"salmon",@"curtain", nil];
    scrambleWords = [[NSMutableArray alloc] initWithCapacity:[masterWordList count]];
    srandom(time(NULL));
    int randomNum;
    
    for (int i = 0; i < 10; i++) {
        randomNum = (random() % [masterWordList count]);
        [scrambleWords addObject:[masterWordList objectAtIndex:randomNum]];
    }
}

-(NSString *)scrambleWord:(NSString *)wordToScramble{
    NSMutableSet *usedNumberSet = [[NSMutableSet alloc] init];
    NSMutableString *outputString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [wordToScramble length]; i++) {
        int randomNum = random() % [wordToScramble length];
        while ([usedNumberSet containsObject:[NSNumber numberWithInt:randomNum]]) {
            randomNum = random() % [wordToScramble length];
        }
        
        [usedNumberSet addObject:[NSNumber numberWithInt:randomNum]];
        [outputString appendFormat:@"%c", [wordToScramble characterAtIndex:randomNum]];
    }
    return outputString;
}
@end
