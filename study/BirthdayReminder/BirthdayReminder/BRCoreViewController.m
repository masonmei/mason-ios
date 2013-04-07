//
//  BRCoreViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRCoreViewController ()

@end

@implementation BRCoreViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app-background.png"]];
    [self.view insertSubview:backgroundView atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelAndDismiss:(id)sender{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)saveAndDismiss:(id)sender{
    NSLog(@"Save");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
