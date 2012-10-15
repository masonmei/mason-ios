//
//  ViewController.m
//  MultiToucher
//
//  Created by Mason Mei on 9/16/12.
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.view.multipleTouchEnabled=YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint touchLocation;
        touchLocation = [touch locationInView:self.view];
        NSLog(@"touchedBegan at: %f, %f",touchLocation.x, touchLocation.y);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint touchLocation;
        touchLocation = [t locationInView:self.view];
        NSLog(@"touchesMoved at: %f, %f",touchLocation.x, touchLocation.y);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint touchLocation;
        touchLocation = [t locationInView:self.view];
        NSLog(@"touchesEnded at: %f, %f",touchLocation.x, touchLocation.y);
    }
}
@end
