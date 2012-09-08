//
//  ScramblePlayer.h
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScramblePlayer : NSObject{
    NSMutableArray * scrambleWords;
}

-(NSString *)getNextWord;
-(NSString *)scrambleWord:(NSString *) wordToScramble;
-(int)getRemainingWordCount;
-(void)initializeWordList;

@end
