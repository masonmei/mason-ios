//
//  ViewController.m
//  DateCalc
//
//  Created by Mason Mei on 8/8/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize outputLabel;
@synthesize dateChooserVisible;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setOutputLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showDateChooser:(id)sender {
    if(!self.dateChooserVisible){
        [self performSegueWithIdentifier:@"toDateChooser" sender:sender];
        self.dateChooserVisible = YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ((DateChooserViewController *)segue.destinationViewController).delegate = self;
}

-(void) calculateDateDifference:(NSDate *) chosenDate{
    NSDate *toDaysDate;
    NSString *differenceOutput;
    NSString *todaysDateString;
    NSString *chosenDateString;
    NSDateFormatter *format;
    NSTimeInterval difference;
    
    toDaysDate = [NSDate date];
    difference = [toDaysDate timeIntervalSinceDate:chosenDate] / 86400;
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM d, yyyy hh:mm:ssa"];
    todaysDateString = [format stringFromDate:toDaysDate];
    chosenDateString = [format stringFromDate:chosenDate];
    differenceOutput = [[NSString alloc] initWithFormat:@"Difference between chosen date (%@) and today (%@) in days: %1.2f", chosenDateString, todaysDateString, fabs(difference)];
    self.outputLabel.text = differenceOutput;
}
@end
