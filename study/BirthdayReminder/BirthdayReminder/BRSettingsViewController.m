//
//  BRSettingsViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRSettingsViewController.h"
#import "BRDSettings.h"
#import "BRStyleSheet.h"
#import "BRDModel.h"
#import "Appirater.h"
#import <Social/Social.h>

@interface BRSettingsViewController ()

@end

@implementation BRSettingsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tableCellNotificationTime.detailTextLabel.text = [[BRDSettings sharedInstance] titleForNotificationTime];
    self.tableCellDaysBefore.detailTextLabel.text = [[BRDSettings sharedInstance] titleForDaysBefore:[BRDSettings sharedInstance].daysBefore];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app-background.png"]];
    self.tableView.backgroundView = backgroundView;
}

- (IBAction)didClickDoneButton:(id)sender {
    [[BRDModel sharedInstance] updateCachedBirthdays];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView *) createSectionHeaderWithLabel:(NSString *)text{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40.f)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 15.f, 300.f, 20.f)];
    
    label.backgroundColor = [UIColor clearColor];
    [BRStyleSheet styleLabel:label withType:BRLabelTypeLarge];
    label.text = text;
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  40.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return section == 0 ?  [self createSectionHeaderWithLabel:@"Reminders"] : [self createSectionHeaderWithLabel:@"Share the love"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return;
    }
    
    NSString *text = @"Check out this iPhone App: Birthday Reminder";
    UIImage *image = [UIImage imageNamed:@"icon300x300.png"];
    NSURL *facebookPageLink = [NSURL URLWithString:@"http://www.facebook.com/apps/application.php?id=561988173822866"];
    NSURL *appStoreLink = [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=489637509"];
    
    SLComposeViewController *slComposeViewController;
    
    switch (indexPath.row) {
        case 0:{
            [Appirater rateApp];
            break;
        }
        case 1:{
            if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
                NSLog(@"No facebook account available for user");
                return;
            }
            
            slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [slComposeViewController addImage:image];
            [slComposeViewController setInitialText:text];
            [slComposeViewController addURL:appStoreLink];
            [self presentViewController:slComposeViewController animated:YES completion:nil];
            break;
        }
        case 2:{
            [[UIApplication sharedApplication] openURL:facebookPageLink];
            break;
        }
        case 3:{
            if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
                NSLog(@"No twitter account available for user");
                return;
            }
            
            slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [slComposeViewController addImage:image];
            [slComposeViewController setInitialText:text];
            [slComposeViewController addURL:appStoreLink];
            [self presentViewController:slComposeViewController animated:YES completion:nil];
            break;
        }
        case 4:{
            if(![MFMailComposeViewController canSendMail]){
                NSLog(@"Cannot send email");
                return;
            }
            MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
            [mailComposeViewController addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"pic.png"];
            [mailComposeViewController setSubject:@"Birthday Reminder"];
            
            NSString *textWithLink = [NSString stringWithFormat:@"%@\n\n%@", text, appStoreLink];
            
            [mailComposeViewController setMessageBody:textWithLink isHTML:NO];
            mailComposeViewController.mailComposeDelegate = self;
            [self presentViewController:mailComposeViewController animated:YES completion:nil];
            break;
        }
        case 5: {
            if(![MFMessageComposeViewController canSendText]){
                NSLog(@"Can't send messages");
                return;
            }
            
            MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc]init];
                
            NSString *textWithLink = [NSString stringWithFormat:@"%@\n\n%@", text, appStoreLink];
                
            [messageViewController setBody:textWithLink];
            messageViewController.messageComposeDelegate = self;
            [self presentViewController:messageViewController animated:YES completion:nil];
            break;
        }
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:{
            NSLog(@"message composer cancelled");
            break;
        }
        case MessageComposeResultFailed:{
            NSLog(@"message composer failed");
            break;
        }
        case MessageComposeResultSent:{
            NSLog(@"message composer sent");
            break;
        }
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:{
            NSLog(@"mail composer cancelled");
            break;
        }
        case MFMailComposeResultFailed:{
            NSLog(@"mail composer failed");
            break;
        }
        case MFMailComposeResultSaved:{
            NSLog(@"mail composer saved");
            break;
        }
        case MFMailComposeResultSent:{
            NSLog(@"mail composer sent");
            break;
        }
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
