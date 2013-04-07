//
//  BRBirthdayEditViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRBirthdayEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"
#import "UIImage+Thumbnail.h"
#import "BRStyleSheet.h"
#import "UIImageView+RemoteFile.h"

@interface BRBirthdayEditViewController ()

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation BRBirthdayEditViewController

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
    [BRStyleSheet styleLabel:self.includeYearLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleRoundCorneredView:self.photoContainerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    return NO;
}

- (IBAction)didChangeNameText:(id)sender {
    NSLog(@"The text was changed: %@", self.nameTextField.text);
    self.birthday.name = self.nameTextField.text;
    [self updateSaveButton];
}

- (IBAction)didToggleSwitch:(id)sender {
    [self updateBirthdayDetails];
}

- (IBAction)didChangeDatePicker:(id)sender {
    NSLog(@"New Birthday Selected: %@", self.datePicker.date);
    [self updateBirthdayDetails];
}

- (IBAction)didTapPhoto:(id)sender {
    NSLog(@"Did tap Photo!");
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"No Camera Detected!");
        [self pickPhoto];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo", @"Pick from Photo Library", nil];
    [actionSheet showInView:self.view];
}

-(void) updateSaveButton{
    self.saveButton.enabled = self.nameTextField.text.length > 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.nameTextField.text = self.birthday.name;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    if([self.birthday.birthDay intValue] > 0){
        components.day = [self.birthday.birthDay intValue];
    }
    
    if([self.birthday.birthMonth intValue] > 0){
        components.month = [self.birthday.birthMonth intValue];
    }
    
    if ([self.birthday.birthYear intValue] > 0) {
        components.year = [self.birthday.birthYear intValue];
        self.includeYearSwitch.on = YES;
    }else{
        self.includeYearSwitch.on = NO;
    }
    
    [self.birthday updateBirthdayAndAge];
    self.datePicker.date = [calendar dateFromComponents:components];

    if(self.birthday.imageData == nil){
        if([self.birthday.picURL length] > 0){
            [self.photoView setImageWithRemoteFileURL:self.birthday.picURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
        } else {
            self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
        }
    } else {
        self.photoView.image = [UIImage imageWithData:self.birthday.imageData];
    }
    
    [self updateSaveButton];
}

-(UIImagePickerController *)imagePicker{
    if(_imagePicker == nil){
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGFloat side = 71.f;
    side *= [[UIScreen mainScreen] scale];
    
    UIImage *thumbnail = [image createThumbnailToFillSize:CGSizeMake(side, side)];
    self.photoView.image = thumbnail;
    
    self.birthday.imageData = UIImageJPEGRepresentation(thumbnail, 1.f);
}

-(void) takePhoto{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void) pickPhoto{
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == actionSheet.cancelButtonIndex){
        return;
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self pickPhoto];
            break;
        }
}

-(void) updateBirthdayDetails{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self.datePicker.date];
    self.birthday.birthMonth = @(components.month);
    self.birthday.birthDay = @(components.day);
    
    if(self.includeYearSwitch.on){
        self.birthday.birthYear = @(components.year);
    }else{
        self.birthday.birthYear = @0;
    }
    [self.birthday updateBirthdayAndAge];
}

-(IBAction) saveAndDismiss:(id)sender{
    [[BRDModel sharedInstance] saveChanges];
    [[BRDModel sharedInstance] updateCachedBirthdays];
    [super saveAndDismiss:sender];
}

-(IBAction)cancelAndDismiss:(id)sender{
    [[BRDModel sharedInstance] cancelChanges];
    [super cancelAndDismiss:sender];
}

@end
