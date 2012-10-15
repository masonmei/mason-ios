//
//  HBTabBarController.m
//  Health Beat
//
//  Created by Mason Mei on 10/14/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "HBTabBarController.h"
#import "HBWeightHistory.h"

@interface HBTabBarController ()

@end

@implementation HBTabBarController
@synthesize weightHistory = _weightHistory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.weightHistory = [[HBWeightHistory alloc]init];
    NSMutableArray *stack = [NSMutableArray arrayWithArray:self.viewControllers];
    
    while ([stack count] > 0) {
        id controller = [stack lastObject];
        [stack removeLastObject];
        
        if([controller respondsToSelector:@selector(viewControllers)]){
            [stack addObjectsFromArray:[controller viewControllers]];
        }
        
        if([controller respondsToSelector:@selector(setWeightHistory:)]){
            [self setWeightHistory:self.weightHistory];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
