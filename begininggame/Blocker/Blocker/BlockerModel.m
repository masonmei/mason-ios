//
//  BlockerModel.m
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "BlockerModel.h"

@implementation BlockerModel
@synthesize blocks, ballRect, paddleRect;

-(id)init{
    self = [super init];
    
    if(self){
        blocks = [[NSMutableArray alloc] initWithCapacity:15];
        BlockerView *bv;
        
        for(int row = 0; row < 3; row++){
            for (int col = 0; col < 5; col++) {
                bv = [[BlockerView alloc] initWithFrame:CGRectMake(col * BLOCKER_WIDTH, row * BLOCKER_HEIGHT,BLOCKER_WIDTH, BLOCKER_HEIGHT) color:row];
                [blocks addObject:bv];
            }
        }
        
        UIImage *paddleImage = [UIImage imageNamed:@"paddle.png"];
        CGSize paddleSize = [paddleImage size];
        paddleRect = CGRectMake(0.0, 420.0, paddleSize.width, paddleSize.height);
        
        UIImage * ballImage = [UIImage imageNamed:@"ball.png"];
        CGSize ballSize = [ballImage size];
        ballRect = CGRectMake(180.0, 220.0, ballSize.width, ballSize.height);
        
        ballVelocity = CGPointMake(200, -200);
        lastTime = 0.0;
    }
    return self;
}

-(void)checkCollisionWithScreenEdges{
    if(ballRect.origin.x <=0){
        ballVelocity.x = abs(ballVelocity.x);
    }
    
    if(ballRect.origin.x >= VIEW_WIDTH - BALL_SIZE){
        ballVelocity.x = -1 * abs(ballVelocity.x);
    }
    
    if(ballRect.origin.y <= 0){
        ballVelocity.y = abs(ballVelocity.y);
    }
    
    if(ballRect.origin.y >= VIEW_HEIGHT - BALL_SIZE){
        ballRect.origin.x = 180.0;
        ballRect.origin.y = 220.0;
        ballVelocity.y = -1 * abs(ballVelocity.y);
    }
}

-(void)checkCollisionWithBlocks{
    for (BlockerView *bv in blocks) {
        if(CGRectIntersectsRect(bv.frame, ballRect)){
            ballVelocity.y = -ballVelocity.y;
            [blocks removeObject:bv];
            [bv removeFromSuperview];
            break;
        }
    }
}

-(void)checkCollisionWithPaddle{
    if(CGRectIntersectsRect(ballRect, paddleRect)){
        ballVelocity.y = -1 * abs(ballVelocity.y);
    }
}

-(void)updateModelWithTime:(CFTimeInterval)timestamp{
    if(lastTime == 0.0){
        lastTime = timestamp;
    }
    else{
        timeDelta = timestamp - lastTime;
        lastTime = timestamp;
        
        ballRect.origin.x += ballVelocity.x * timeDelta;
        ballRect.origin.y += ballVelocity.y * timeDelta;
        
        [self checkCollisionWithScreenEdges];
        [self checkCollisionWithBlocks];
        [self checkCollisionWithPaddle];
    }
}

@end
