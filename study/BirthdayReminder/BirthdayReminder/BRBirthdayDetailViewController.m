//
//  BRBirthdayDetailViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"
#import "BRNotesEditViewController.h"
#import "BRDBirthday.h"
#import "BRStyleSheet.h"
#import <AddressBook/AddressBook.h>
#import "BRDModel.h"
#import "UIImageView+RemoteFile.h"
#import "BRPostToFacebookViewController.h"

@interface BRBirthdayDetailViewController ()

@end

@implementation BRBirthdayDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        NSLog(@"initWithCoder");
    }
    return self;
}

-(void)dealloc{
    NSLog(@"dealloc");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    self.title = _birthday.name;
    
    if(self.birthday.imageData == nil){
        if([self.birthday.picURL length] > 0){
            [self.photoView setImageWithRemoteFileURL:self.birthday.picURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
        } else {
            self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
        }
    } else {
        self.photoView.image = [UIImage imageWithData:self.birthday.imageData];
    }
    
    
    int days = self.birthday.remainingDaysUntilNextBirthday;
    
    if(days == 0){
        self.remainingDaysLabel.text = self.remainingDaysSubTextLabel.text = @"";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    } else{
        self.remainingDaysLabel.text = [NSString stringWithFormat:@"%d", days];
        self.remainingDaysSubTextLabel.text = (days == 1)? @"more day": @"more days";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-days-remaining.png"];
    }
    
    self.birthdayLabel.text = self.birthday.birthdayTextToDisplay;
    
    NSString *notes = (self.birthday.note && self.birthday.note.length > 0) ?
    self.birthday.note : @"";
    CGFloat cY = self.notesTextLabel.frame.origin.y;
    CGSize notesLabelSize = [notes sizeWithFont:self.notesTextLabel.font
                              constrainedToSize:CGSizeMake(300.f, 300.f) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = self.notesTextLabel.frame;
    frame.size.height = notesLabelSize.height;
    self.notesTextLabel.frame = frame;
    self.notesTextLabel.text = notes;
    cY += frame.size.height;
    cY += 10.f;
    CGFloat buttonGap = 6.f;
    cY += buttonGap * 2;
    NSMutableArray *buttonsToShow = [NSMutableArray
                                     arrayWithObjects:self.facebookButton,self.callButton, self.smsButton, self.emailButton,
                                     self.deleteButton, nil];
    NSMutableArray *buttonToHide = [NSMutableArray array];
    
    if(self.birthday.facebookID == nil){
        [buttonsToShow removeObject:self.facebookButton];
        [buttonToHide addObject:self.facebookButton];
    }
    if([self callLink] == nil){
        [buttonsToShow removeObject:self.callButton];
        [buttonToHide addObject:self.callButton];
    }
    if([self smsLink] == nil){
        [buttonsToShow removeObject:self.smsButton];
        [buttonToHide addObject:self.smsButton];
    }
    if([self emailLink] == nil){
        [buttonsToShow removeObject:self.emailButton];
        [buttonToHide addObject:self.emailButton];
    }
    
    for (UIButton *button in buttonToHide) {
        button.hidden = YES;
    }
    
    UIButton *button;
    int i;
    for (i=0;i<[buttonsToShow count];i++) {
        button = [buttonsToShow objectAtIndex:i];
        button.hidden = NO;
        frame = button.frame;
        frame.origin.y = cY;
        button.frame = frame;
        cY += button.frame.size.height + buttonGap;
    }
    self.scrollView.contentSize = CGSizeMake(320, cY);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    
    [BRStyleSheet styleRoundCorneredView:self.photoView];
    
    [BRStyleSheet styleLabel:self.birthdayLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.notesTitleLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.notesTextLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.remainingDaysLabel withType:BRLabelTypeDaysUntilBirthday];
    [BRStyleSheet styleLabel:self.remainingDaysSubTextLabel withType:BRLabelTypeDaysUntilBirthdaySubText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"EditBirthday"]){
        UINavigationController *navigationController = segue.destinationViewController;
        BRBirthdayEditViewController *birthdayEditViewController =(BRBirthdayEditViewController *)navigationController.topViewController;
        birthdayEditViewController.birthday = self.birthday;
    } else if([identifier isEqualToString:@"EditNotes"]){
        UINavigationController *navigationController = segue.destinationViewController;
        BRNotesEditViewController *notesEditViewController = (BRNotesEditViewController *)navigationController.topViewController;
        notesEditViewController.birthday = self.birthday;
    }
}
- (IBAction)facebookButtonTapped:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostToFacebook"];
    
    BRPostToFacebookViewController *postToFacebookViewController = (BRPostToFacebookViewController *)navigationController.topViewController;
    postToFacebookViewController.facebookId = self.birthday.facebookID;
    postToFacebookViewController.initialPostText = @"Happy Birthday!";
    
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)callButtonTapped:(id)sender {
    NSString *callLink = [self callLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callLink]];
}

- (IBAction)smsButtonTapped:(id)sender {
    NSString *smsLink = [self smsLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:smsLink]];
}

- (IBAction)emailButtonTapped:(id)sender{
    NSString *emailLink = [self emailLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailLink]];
}

- (IBAction)deleteButtonTapped:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:[NSString stringWithFormat:@"Delete %@", self.birthday.name] otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == actionSheet.cancelButtonIndex){
        return;
    }
    
    NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
    [context deleteObject:self.birthday];
    [[BRDModel sharedInstance] saveChanges];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)telephoneNumber{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, [self.birthday.addressBookID intValue]);
    ABMultiValueRef multi = ABRecordCopyValue(record, kABPersonPhoneProperty);
    
    NSString *telephone = nil;
    
    if(ABMultiValueGetCount(multi) > 0){
        telephone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multi, 0);
        telephone = [telephone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    CFRelease(multi);
    CFRelease(addressBook);
    return telephone;
}

-(NSString *) callLink{
    if(!self.birthday.addressBookID || [self.birthday.addressBookID intValue] == 0){
        return nil;
    }
    
    NSString *telephoneNumber = [self telephoneNumber];
    
    if(!telephoneNumber){
        return nil;
    }
    
    NSString *callLink = [NSString stringWithFormat:@"tel:%@", telephoneNumber];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callLink]]){
        return callLink;
    }
    
    return nil;
}

-(NSString *)smsLink{
    if (!self.birthday.addressBookID || [self.birthday.addressBookID intValue] == 0){
        return nil;
    }
    
    NSString *telephoneNumber = [self telephoneNumber];
    if (!telephoneNumber) {
        return nil;
    }
    
    NSString *smsLink = [NSString stringWithFormat:@"sms:%@",telephoneNumber];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:smsLink]]) {
        return smsLink;
    }
    
    return nil;
}

-(NSString *)emailLink
{
    if (!self.birthday.addressBookID || [self.birthday.addressBookID intValue]==0) {
        return nil;
    }
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook,(ABRecordID)[self.birthday.addressBookID intValue]);
    ABMultiValueRef multi = ABRecordCopyValue(record, kABPersonEmailProperty);
    NSString *email = nil;
    
    if (ABMultiValueGetCount(multi) > 0) {//check if the contact has 1 or more emails assigned
        email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(multi, 0);
    }
    
    CFRelease(multi);
    CFRelease(addressBook);
    
    if (email) {
        NSString *emailLink = [NSString stringWithFormat:@"mailto:%@",email];
        //we can pre-populate the email subject with the words Happy Birthday
        emailLink = [emailLink stringByAppendingString:@"?subject=Happy%20Birthday"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:emailLink]])
            return emailLink;
    }
    return nil;
}
@end
