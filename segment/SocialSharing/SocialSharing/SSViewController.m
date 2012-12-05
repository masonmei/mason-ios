//
//  SSViewController.m
//  SocialSharing
//
//  Created by masonmei on 12/5/12.
//  Copyright (c) 2012 personal.org. All rights reserved.
//

#import "SSViewController.h"
#import <Social/Social.h>

@interface SSViewController ()

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postToTweet:(id)sender {
    [self postToSocial:SLServiceTypeTwitter withContent:@"So easy to using tweet"];
}

- (IBAction)postToFacebook:(id)sender {
    [self postToSocial:SLServiceTypeFacebook withContent:@"So easy to using facebook"];
}

- (IBAction)postToSina:(id)sender {
    [self postToSocial:SLServiceTypeSinaWeibo withContent:@"So easy to using sina"];
}

-(void) postToSocial:(NSString *) socialType withContent:(NSString *) content {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:socialType];
        [tweetSheet setInitialText:content];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
@end
