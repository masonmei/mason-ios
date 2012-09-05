//
//  ViewController.m
//  BestFriend
//
//  Created by Mason Mei on 9/5/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize name;
@synthesize email;
@synthesize photo;
@synthesize map;
@synthesize zipAnnotation;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setEmail:nil];
    [self setPhoto:nil];
    [self setMap:nil];
    [self setZipAnnotation:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)newBFF:(id)sender {
    ABPeoplePickerNavigationController *picker;
    picker = [[ABPeoplePickerNavigationController alloc]init];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)sendEmail:(id)sender {
    MFMailComposeViewController *mailController;
    NSArray *emailAddress;
    emailAddress = [[NSArray alloc] initWithObjects:self.email.text, nil];
    
    mailController = [[MFMailComposeViewController alloc]init];
    mailController.mailComposeDelegate = self;
    [mailController setToRecipients:emailAddress];
    [self presentModalViewController:mailController animated:YES];
}

- (IBAction)sendTweet:(id)sender {
    TWTweetComposeViewController *tweetComposer;
    tweetComposer = [[TWTweetComposeViewController alloc] init];
    if([TWTweetComposeViewController canSendTweet]){
        [tweetComposer setInitialText:@"I am on my way"];
        [self presentModalViewController:tweetComposer animated:YES];
    }
}

-(void)centerMap:(NSString *)zipCode showAddress:(NSDictionary *)fullAddress{
    NSString *queryURL;
    NSString *queryResult;
    NSArray *queryData;
    
    double latitude;
    double longtitude;
    
    MKCoordinateRegion mapRegion;
    
    queryURL = [[NSString alloc] initWithFormat:@"http://map.google.com/maps/geo?output=csv&q=%@", zipCode];
    
    queryResult = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:queryURL] encoding:NSUTF8StringEncoding error:nil];
    
    queryData = [queryResult componentsSeparatedByString:@","];
    
    if([queryData count] == 4){
        latitude = [[queryData objectAtIndex:2] doubleValue];
        longtitude = [[queryData objectAtIndex:3] doubleValue];
        mapRegion.center.latitude = latitude;
        mapRegion.center.longitude = longtitude;
        mapRegion.span.latitudeDelta = 0.2;
        mapRegion.span.longitudeDelta = 0.2;
        [self.map setRegion:mapRegion animated:YES];
        
        if(zipAnnotation != nil){
            [self.map removeAnnotation:zipAnnotation];
        }
        zipAnnotation = [[MKPlacemark alloc] initWithCoordinate:mapRegion.center addressDictionary:fullAddress];
        [map addAnnotation:zipAnnotation];
    }
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissModalViewControllerAnimated:YES];
}
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    NSString *fname;
    NSString *femail;
    NSString *fzip;
    
    fname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    self.name.text = fname;
    
    ABMultiValueRef fAddressSet;
    NSDictionary *fFirstAddress;
    fAddressSet = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    if(ABMultiValueGetCount(fAddressSet) > 0){
        fFirstAddress = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(fAddressSet, 0);
        fzip = [fFirstAddress objectForKey:@"ZIP"];
        [self centerMap:fzip showAddress:fFirstAddress];
    }

    ABMultiValueRef fEmailAddress;
    fEmailAddress = ABRecordCopyValue(person, kABPersonEmailProperty);
    if(ABMultiValueGetCount(fEmailAddress) > 0){
        femail = (__bridge NSString * )ABMultiValueCopyValueAtIndex(fEmailAddress, 0);
        self.email.text = femail;
    }
    
    if(ABPersonHasImageData(person)){
        self.photo.image = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageData(person)];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myspot"];
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorPurple;
    return pinView;
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}
@end
