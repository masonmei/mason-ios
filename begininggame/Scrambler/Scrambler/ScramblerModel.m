//
//  ScramblerModel.m
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ScramblerModel.h"

@implementation ScramblerModel
@synthesize time;
@synthesize score;

-(id)init{
    if(self = [super init]){
        computerPlayer = [[ScramblePlayer alloc] init];
        time = 60;
        score = 0;
        currentWord = [computerPlayer getNextWord];
        return self;
    }
    return nil;
}

-(BOOL) checkGuess: (NSString *) guess{
    if([guess isEqualToString:currentWord]){
        score ++;
        time += 15;
        if([computerPlayer getRemainingWordCount] > 0){
            currentWord = [computerPlayer getNextWord];
        } else{
            currentWord = nil;
        }
        return YES;
    }else{
        time -= 10;
        
        return NO;
    }
}

-(NSString *)getScrambledWord{
    return [computerPlayer getNextWord];
}

-(void)timeTick{
    time--;
}
@end
