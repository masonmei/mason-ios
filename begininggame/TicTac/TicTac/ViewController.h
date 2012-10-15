//
//  ViewController.h
//  TicTac
//
//  Created by Mason Mei on 9/23/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "GameState.h"

typedef enum {
    TTMyShapeUndeterminde = 0,
    TTMyShapeX = 1,
    TTMyShapeO = 2
} TTMyShape;

typedef enum {
    TTGameNotOver = 0,
    TTGameOverxWins = 1,
    TTGameOveroWins = 2,
    TTGameOverTie = 3
} TTGameOverStatus;

@interface ViewController : UIViewController <UIAlertViewDelegate, GKPeerPickerControllerDelegate>{
    UIImage* xImage;
    UIImage* oImage;
    
    GameState* theGameState;
    
    TTMyShape myShape;
    NSString* myUUID;
    GKSession* theSession;
    NSString* myPeerID;
}
@property (strong, nonatomic) UIImage* xImage;
@property (strong, nonatomic) UIImage* oImage;
@property (strong, nonatomic) GameState* theGameState;

@property TTMyShape myShape;
@property (strong, nonatomic) NSString* myUUID;
@property (strong, nonatomic) IBOutlet GKSession* theSession;
@property (strong,nonatomic) IBOutlet NSString* myPeerID;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *spaceButton;

- (IBAction)spaceButtonTapped:(id)sender;

- (void) initGame;
- (void) updateBoard;
- (void) updateGameStatus;
- (TTGameOverStatus) checkGameOver;
- (BOOL) didPlayerWin:(NSString *) player;
- (void) endGameWithResult:(TTGameOverStatus) result;

-(NSString *)getUUIDString;
@end
