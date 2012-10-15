//
//  GameState.m
//  TicTac
//
//  Created by Mason Mei on 9/23/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "GameState.h"

@implementation GameState
@synthesize playersTurn, boardState;

- (id)init
{
    self = [super init];
    if (self) {
        boardState = [[NSMutableArray alloc] initWithCapacity:9];
        playersTurn=TTxPlayerTurn;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    boardState = [aDecoder decodeObjectForKey:@"BoardState"];
    playersTurn = [aDecoder decodeIntForKey:@"playersTurn"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:boardState forKey:@"BoardState"];
    [aCoder encodeInt:playersTurn forKey:@"PlayersTurn"];
}
@end
