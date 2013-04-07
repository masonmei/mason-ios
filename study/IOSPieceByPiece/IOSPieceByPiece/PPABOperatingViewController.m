//
//  PPABOperatingViewController.m
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/20/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "PPABOperatingViewController.h"

NSString *const kDenied = @"Access to address book is denied";
NSString *const kRestricted = @"Access to address book is restricted";

@interface PPABOperatingViewController (){
    NSArray *allContacts;
}

@end

@implementation PPABOperatingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadAllContacts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"ContactItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    // Configure the cell...
    ABRecordRef recordRef = (__bridge ABRecordRef)(allContacts[indexPath.row]);
    NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(recordRef, kABPersonFirstNameProperty));
    NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(recordRef, kABPersonLastNameProperty));
    NSString *name = [NSString stringWithFormat:@"%@%@", lastName.length > 0 ? lastName : @"", firstName.length > 0 ? firstName : @""];
    
    //ABMutableMultiValueRef phones = ABRecordCopyValue(recordRef, kABPersonPhoneProperty);
    //if(phones == nil){
    //    NSLog(@"There is no phone for %@", name);
    //}
//    NSMutableString *phoneString = [[[NSString alloc] init] mutableCopy];
//    if(phones != nil && ABMultiValueGetCount(phones) > 0){
//        for (int count = 0; count < ABMultiValueGetCount(phones); count++) {
//            if(count > 0){
//                [phoneString appendString:@","];
//            }
//            
//            NSString *phoneNumber = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, count));
//            [phoneString appendString: phoneNumber];
//        }
//    }
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    multiPhone = ABRecordCopyValue(recordRef, kABPersonPhoneProperty);
    
    NSString *content = [NSString stringWithFormat:@"%@ : %@", name, @""];
    cell.textLabel.text = content;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)addContact:(id)sender {
}

-(void)loadAllContacts
{
    CFDictionaryRef dictionaryRef = NULL;
    CFErrorRef errorRef = NULL;
    ABAddressBookRef addressBook;
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            addressBook = ABAddressBookCreateWithOptions(dictionaryRef, &errorRef);
            
            if(addressBook != nil){
                allContacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
                CFRelease(addressBook);
            }
            
            break;
        case kABAuthorizationStatusDenied:
            [self displayMessage:kDenied];
            break;
        case kABAuthorizationStatusRestricted:
            [self displayMessage:kRestricted];
            break;
        case kABAuthorizationStatusNotDetermined:
            addressBook = ABAddressBookCreateWithOptions(NULL, &errorRef);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
                if(granted){
                    NSLog(@"Access was granted");
                }else{
                    NSLog(@"Access was not granted");
                }
                
                if(addressBook != nil){
                    allContacts = (__bridge NSMutableArray *)(ABAddressBookCopyArrayOfAllSources(addressBook));
                    CFRelease(addressBook);
                }
            }) ;
            break;
    }
    
}

-(void)displayMessage:(NSString *) msg
{
    [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
@end
