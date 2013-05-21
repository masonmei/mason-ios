//
//  HGCustomGirlSegue.m
//  HelloGirl
//
//  Created by Mason Mei on 4/9/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "HGCustomGirlSegue.h"

@interface HGCustomGirlSegue (){
    
}

-(void) finishedFadeOut;
-(void) finisedFadeIn;

@end
@implementation HGCustomGirlSegue

-(void)perform{
    // setup our fade to black animation
    [UIView beginAnimations:nil context:nil];   // begins animation block
    [UIView setAnimationDuration:0.75];         // sets animation duration
    
    [UIView setAnimationDelegate:self];         // sets delegate for this block
    [UIView setAnimationDidStopSelector:@selector(finishedFadeOut)];   // calls the finishedFadeOut method when the animation is done
    [[self sourceViewController] view].alpha = 0.5;                     // Fades the alpha channel to "0.0" over the "0.75" seconds
    [UIView commitAnimations];                  // ends the block and executes it
}

-(void)finishedFadeOut{
    [[self destinationViewController] view].alpha = 0.0;       // ensure destination not visible
    
    // push our destination view (albeit we can't see it yet...)
    UINavigationController *navController = [[self sourceViewController] navigationController];
    [navController pushViewController:[self destinationViewController] animated:NO];
    
    // now animate the view into being seen
    [UIView beginAnimations:nil context:nil];   // begins animation block
    [UIView setAnimationDuration:0.75];          // sets animation duration
    [UIView setAnimationDelegate:self];         // sets delegate for this block
    [UIView setAnimationDidStopSelector:@selector(finishedFadeIn)];   // calls the finishedFading method when the animation
    [[self destinationViewController] view].alpha = 1.0;   // fades the view to 1.0 alpha over 1.0 seconds
    [UIView commitAnimations];                  // ends the block and executes it
}

-(void)finisedFadeIn{
    [[self sourceViewController] view].alpha = 1.0;       // ensure that view we left is visible when we press back button
    [UIView commitAnimations];
}
@end
