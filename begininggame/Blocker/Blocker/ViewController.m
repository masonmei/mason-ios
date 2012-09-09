//
//  ViewController.m
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gameModel = [[BlockerModel alloc]init];
    
    for (BlockerView *bv in gameModel.blocks) {
        [self.view addSubview:bv];
    }
    
    paddle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paddle.png"]];
    [paddle setFrame:gameModel.paddleRect];
    
    [self.view addSubview:paddle];
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    [ball setFrame:gameModel.ballRect];
    
    [self.view addSubview:ball];
    
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)updateDisplay:(CADisplayLink *)sender{
    [gameModel updateModelWithTime:sender.timestamp];
    
    [ball setFrame:gameModel.ballRect];
    [paddle setFrame:gameModel.paddleRect];
    
    if([gameModel.blocks count] == 0){
        [self endGameWithMessage:@"You Succeed destoryed all of the blocks!"];
    }
}

-(void)endGameWithMessage:(NSString *)message{
    [gameTimer invalidate];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGFloat delta = [t locationInView:self.view].x - [t previousLocationInView:self.view].x;
        CGRect newPaddleRect = gameModel.paddleRect;
        newPaddleRect.origin.x += delta;
        gameModel.paddleRect = newPaddleRect;
    }
}
@end
