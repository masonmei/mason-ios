//
//  ViewController.h
//  Scrambler
//
//  Created by Mason Mei on 9/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScramblerModel.h"

@interface ViewController : UIViewController{
    ScramblerModel * gameModel;
    NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UILabel *scrambleWord;
@property (strong, nonatomic) IBOutlet UILabel *remainingTime;
@property (strong, nonatomic) IBOutlet UILabel *playerScore;
@property (strong, nonatomic) IBOutlet UITextField *guessText;

- (IBAction)guessTap:(id)sender;
- (void) endGameWithMessage: (NSString *)message;
@end
