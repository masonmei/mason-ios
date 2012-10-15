//
//  GameState.h
//  TicTac
//
//  Created by Mason Mei on 9/23/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTxPlayerTurn = 1,
    TToPlayerTurn = 2
} TTPlayerTurn;

@interface GameState : NSObject<NSCoding>{
    TTPlayerTurn playersTurn;
    NSMutableArray* boardState;
}

@property TTPlayerTurn playersTurn;
@property (strong, nonatomic) NSMutableArray* boardState;

@end
