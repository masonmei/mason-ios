//
//  ViewController.h
//  SimonSays
//
//  Created by Mason Mei on 9/16/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeView.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>{
    UILabel* simonLabel;
    NSTimer* gameTimer;
    // Track what simon said
    int shouldTouchShape;
    bool simonSaid;
    float timerLength;
}

-(void) getSimonString;
-(void )timerFired:(NSTimer*)theTimer;
-(void) endGameWithMessage:(NSString*) message;

@end
