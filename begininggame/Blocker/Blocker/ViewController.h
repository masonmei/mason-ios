//
//  ViewController.h
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockerModel.h"
#import "BlockerView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController{
    BlockerModel *gameModel;
    UIImageView *ball;
    UIImageView *paddle;
    
    CADisplayLink *gameTimer;
}

-(void) updateDisplay:(CADisplayLink *) sender;
-(void) endGameWithMessage:(NSString *) message;

@end
