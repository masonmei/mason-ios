//
//  ViewController.m
//  SlowCount
//
//  Created by Mason Mei on 9/6/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize theCount;
@synthesize theTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    counterTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    count = 0;
    self.theTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countUp) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [self setTheCount:nil];
    [self setTheTimer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)countUp{
    if(count == 1000){
        [self.theTimer invalidate];
        [self setTheTimer:nil];
        [[UIApplication sharedApplication] endBackgroundTask:counterTask];
    } else{
        count ++;
        NSString * currentCount;
        currentCount = [[NSString alloc] initWithFormat:@"%d", count];
        self.theCount.text = currentCount;
    }
}

@end
