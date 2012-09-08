//
//  ScramblerModel.h
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScramblePlayer.h"

@interface ScramblerModel : NSObject{
    ScramblePlayer *computerPlayer;
    int time;
    int score;
    NSString *currentWord;
}

@property (readonly) int time;
@property (readonly) int score;

-(void) timeTick;
-(BOOL) checkGuess: (NSString *) guess;
-(NSString *)getScrambledWord;
@end
