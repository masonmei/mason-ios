//
//  BRNotesEditViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRNotesEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"
#import "BRStyleSheet.h"

@interface BRNotesEditViewController ()

@end

@implementation BRNotesEditViewController

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
    [BRStyleSheet styleTextView:self.textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"User changed the notes text: %@", self.textView.text);
    self.birthday.note = self.textView.text;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.textView.text = self.birthday.note;
    [self.textView becomeFirstResponder];
}

-(IBAction)saveAndDismiss:(id)sender{
    [[BRDModel sharedInstance] saveChanges];
    [super saveAndDismiss:sender];
}

-(IBAction) cancelAndDismiss:(id)sender{
    [[BRDModel sharedInstance] cancelChanges];
    [super cancelAndDismiss:sender];
}
@end
