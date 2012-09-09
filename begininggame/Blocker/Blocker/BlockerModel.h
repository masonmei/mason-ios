//
//  BlockerModel.h
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockerView.h"

#define BLOCKER_HEIGHT  20.0
#define BLOCKER_WIDTH   64.0
#define BALL_SIZE       20.0
#define VIEW_WIDTH      320.0
#define VIEW_HEIGHT     640.0

@interface BlockerModel : NSObject{
    NSMutableArray *blocks;
    CGRect paddleRect;
    CGRect ballRect;
    CGPoint ballVelocity;
    CGFloat lastTime;
    CGFloat timeDelta;
}
@property (readonly) NSMutableArray *blocks;
@property (readonly) CGRect ballRect;
@property CGRect paddleRect;

-(void) updateModelWithTime:(CFTimeInterval) timestamp;
-(void) checkCollisionWithScreenEdges;
-(void) checkCollisionWithBlocks;
-(void) checkCollisionWithPaddle;
@end
