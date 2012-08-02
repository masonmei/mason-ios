//
//  ViewController7.m
//  HelloNoun
//
//  Created by Mason Mei on 8/2/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController7.h"

@interface ViewController7 ()

@end

@implementation ViewController7
@synthesize thePlace;
@synthesize theVerb;
@synthesize theNumber;
@synthesize theTemplate;
@synthesize theStory;
@synthesize theButton;

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
    UIImage *normalInage = [[UIImage imageNamed:@"whiteButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    UIImage *pressedImage = [[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    
    [self.theButton setBackgroundImage:normalInage forState:UIControlStateNormal];
    [self.theButton setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setThePlace:nil];
    [self setTheVerb:nil];
    [self setTheNumber:nil];
    [self setTheTemplate:nil];
    [self setTheStory:nil];
    [self setTheButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hideKeyboard:(id)sender {
    [self.thePlace resignFirstResponder];
    [self.theVerb resignFirstResponder];
    [self.theNumber resignFirstResponder];
    [self.theTemplate resignFirstResponder];
}

- (IBAction)createStory:(id)sender {
    self.theStory.text = [self.theTemplate.text stringByReplacingOccurrencesOfString:@"<place>" withString:self.thePlace.text];
    self.theStory.text = [self.theStory.text stringByReplacingOccurrencesOfString:@"<verb>" withString:self.theVerb.text];
    self.theStory.text = [self.theStory.text stringByReplacingOccurrencesOfString:@"<number>" withString:self.theNumber.text];
}
@end
