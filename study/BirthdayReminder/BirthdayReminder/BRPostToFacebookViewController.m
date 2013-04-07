//
//  BRPostToFacebookViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRPostToFacebookViewController.h"
#import "BRStyleSheet.h"
#import "UIImageView+RemoteFile.h"
#import "BRDModel.h"

@interface BRPostToFacebookViewController ()

@end

@implementation BRPostToFacebookViewController

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
    [BRStyleSheet styleRoundCorneredView:self.photoView];
    [BRStyleSheet styleTextView:self.textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *facebookPicURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", self.facebookId];
    
    [self.photoView setImageWithRemoteFileURL:facebookPicURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
    
    self.textView.text = self.initialPostText;
    [self.textView becomeFirstResponder];
    [self updatePostButton];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self updatePostButton];
}

-(void) updatePostButton{
    self.postButton.enabled = [self.textView.text length] > 0;
}

- (IBAction)postToFacebook:(id)sender {
    [[BRDModel sharedInstance] postToFacebook:self.textView.text withFacebookId:self.facebookId];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
