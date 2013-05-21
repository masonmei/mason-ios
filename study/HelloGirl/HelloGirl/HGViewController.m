//
//  HGViewController.m
//  HelloGirl
//
//  Created by Mason Mei on 4/8/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "HGViewController.h"
#import "HGGirlViewController.h"

@interface HGViewController ()

@end

@implementation HGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self girl:nil saysIAmHere:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowGirlView"]){
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setMsgForGirl:self.girlText];
    }
}

-(void)girl:(id)view saysIAmHere:(BOOL)bIsHere{
    self.lblFindStaus.text = bIsHere ? @"Status: Found a Girl" : @"Status: No Girl found";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.girlText = textField.text;
}
@end
