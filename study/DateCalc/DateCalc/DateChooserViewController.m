//
//  DateChooserViewController.m
//  DateCalc
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "DateChooserViewController.h"

@interface DateChooserViewController ()

@end

@implementation DateChooserViewController
@synthesize delegate;

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
}

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)setDateTime:(id)sender {
    [(ViewController *)self.delegate calculateDateDifference:((UIDatePicker *)sender).date];
    
}

- (IBAction)dismissDateChooser:(id)sender {
    ((ViewController *)self.delegate).dateChooserVisible = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    ((ViewController *) self.delegate).dateChooserVisible = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [(ViewController *)self.delegate calculateDateDifference:[NSDate date]];
}
@end
