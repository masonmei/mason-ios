//
//  BRPostToFacebookViewController.h
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRPostToFacebookViewController : BRCoreViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSString *facebookId;
@property (nonatomic, strong) NSString *initialPostText;

- (IBAction)postToFacebook:(id)sender;
@end
