//
//  ViewController.m
//  TicTac
//
//  Created by Mason Mei on 9/23/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize xImage, oImage,theGameState;
@synthesize spaceButton, statusLabel;
@synthesize myShape, myUUID;
@synthesize theSession, myPeerID;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    xImage = [UIImage imageNamed:@"x.png"];
    oImage = [UIImage imageNamed:@"o.png"];
    theGameState = [[GameState alloc] init];
    
    myShape = TTMyShapeUndeterminde;
    myUUID = [self getUUIDString];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initGame];
}

-(void)viewDidAppear:(BOOL)animated{
    GKPeerPickerController *picker = [[GKPeerPickerController alloc]init];
    picker.delegate = self;
    [picker show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)spaceButtonTapped:(id)sender {
//    NSLog(@"Player tapped: %i", [sender tag]);
    int spaceIndex = [sender tag];
    if([[self.theGameState.boardState objectAtIndex:spaceIndex] isEqualToString:@" "] && self.myShape == self.theGameState.playersTurn){
        if(self.theGameState.playersTurn == TTxPlayerTurn){
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject:@"x"];
            self.theGameState.playersTurn = TToPlayerTurn;
        } else {
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject:@"o"];
            self.theGameState.playersTurn = TTxPlayerTurn;
        }
        
        [self updateBoard];
        [self updateGameStatus];
        NSData* theData = [NSKeyedArchiver archivedDataWithRootObject:self.theGameState];
        NSError* error;
        
        [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];
    }
}


- (void) initGame{
    self.theGameState.playersTurn = TTxPlayerTurn;
    
    self.statusLabel.text = @"X to move";
    
    [self.theGameState.boardState removeAllObjects];
    for(int i = 0; i <= 8; i++){
        [self.theGameState.boardState insertObject:@" " atIndex:i];
    }
    
    [self updateBoard];
}

-(void)updateBoard{
    for (int i = 0; i <= 8; i++) {
        if ([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@"x"]) {
            [[spaceButton objectAtIndex:i] setImage:self.xImage forState:UIControlStateNormal];
        } else if ([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@"o"]){
            [[spaceButton objectAtIndex:i] setImage:self.oImage forState:UIControlStateNormal];
        } else {
            [[spaceButton objectAtIndex:i] setImage:nil forState:UIControlStateNormal];
        }
    }
}

-(BOOL)didPlayerWin:(NSString *)player{
    if (([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:1] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:2] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:3] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:5] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:6] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:7] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        
        ([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:3] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:6] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:1] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:7] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:2] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:5] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        
        ([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:2] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:6] isEqualToString:player])) {
        return YES;
    } else {
        return NO;
    }
}

-(TTGameOverStatus)checkGameOver{
    if([self didPlayerWin:@"x"]){
        return TTGameOverxWins;
    }else if ([self didPlayerWin:@"o"]){
        return TTGameOveroWins;
    }
    
    for (int i = 0; i <= 8; i++) {
        if([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@" "]){
            return TTGameNotOver;
        }
    }
    
    return TTGameOverTie;
}

-(void)updateGameStatus{
    TTGameOverStatus gameOverStatus = [self checkGameOver];
    switch (gameOverStatus) {
        case TTGameNotOver:
            if(self.theGameState.playersTurn == TTxPlayerTurn){
                self.statusLabel.text = @"X to move";
            }else{
                self.statusLabel.text = @"O to move";
            }
            break;
        case TTGameOveroWins:
        case TTGameOverTie:
        case TTGameOverxWins:
            [self endGameWithResult:gameOverStatus];
            break;
    }
}
-(void)endGameWithResult:(TTGameOverStatus)result{
    NSString* gameOverMessage;
    
    switch (result) {
        case TTGameOverxWins:
            gameOverMessage = @"X wins";
            break;
        case TTGameOveroWins:
            gameOverMessage = @"O wins";
            break;
            
        case TTGameOverTie:
            gameOverMessage = @"The game is a tie";
            break;
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:gameOverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(NSString *)getUUIDString{
    NSString * result;
    CFUUIDRef uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result = [NSString stringWithFormat:@"%@", uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return result;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self initGame];
}

-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    
    self.theSession = session;
    self.myPeerID = peerID;
    [session setDataReceiveHandler:self withContext:nil];
    [picker dismiss];
    
    NSData* theData = [NSKeyedArchiver archivedDataWithRootObject:self.myUUID];
    NSError* error;
    [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];
}

@end
