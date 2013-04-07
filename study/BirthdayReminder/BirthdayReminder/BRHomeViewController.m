//
//  BRHomeViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/25/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"
#import "BRBrithdayTableViewCell.h"
#import "BRStyleSheet.h"

@interface BRHomeViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;
@property (nonatomic) BOOL hasFriends;

@end

@implementation BRHomeViewController

//-(id)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if(self){
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"birthdays" ofType:@"plist"];
//        NSArray *nonMutableBirthdays = [NSArray arrayWithContentsOfFile:plistPath];
//        
//        BRDBirthday *birthday;
//        NSDictionary *dictionary;
//        NSString *name;
//        NSString *pic;
//        NSString *pathForPic;
//        NSData *imageData;
//        NSDate *birthdate;
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        
//        NSString *uid;
//        NSMutableArray *uids = [NSMutableArray array];
//        for(int i = 0; i < [nonMutableBirthdays count]; i++){
//            dictionary = [nonMutableBirthdays objectAtIndex:i];
//            uid = dictionary[@"uid"];
//            [uids addObject:uid];
//        }
//        
//        NSMutableDictionary *existingEntities = [[BRDModel sharedInstance] getExistingBirthdaysWithUIDs:uids];
//        
//        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
//        
//        for (int i = 0; i < [nonMutableBirthdays count]; i++) {
//            dictionary = [nonMutableBirthdays objectAtIndex:i];
//            uid = dictionary[@"name"];
//            birthday = existingEntities[uid];
//            if(birthday){
//                
//            }else{
//                birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
//                existingEntities[uid] = birthday;
//                birthday.uid = uid;
//            }
//            
//            name = dictionary[@"name"];
//            pic = dictionary[@"pic"];
//            birthdate = dictionary[@"birthdate"];
//            pathForPic = [[NSBundle mainBundle] pathForResource:pic ofType:nil];
//            imageData = [NSData dataWithContentsOfFile:pathForPic];
//            
//            birthday.name = name;
//            birthday.imageData = imageData;
//            NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:birthdate];
//            birthday.birthDay = @(components.day);
//            birthday.birthMonth = @(components.month);
//            birthday.birthYear = @(components.year);
//            
//            [birthday updateBirthdayAndAge];
//        }
//        [[BRDModel sharedInstance] saveChanges];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [BRStyleSheet styleLabel:self.importLabel withType:BRLabelTypeLarge];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.hasFriends = [self.fetchedResultController.fetchedObjects count] > 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCacheBirthdaysDidUpdate:) name:BRNotificationCachedBirthdaysDidUpdate object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRNotificationCachedBirthdaysDidUpdate object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:Identifier];
    
    BRDBirthday *birthday = [self.fetchedResultController objectAtIndexPath:indexPath];
    
    BRBrithdayTableViewCell *brTableCell = (BRBrithdayTableViewCell *)cell;
    brTableCell.birthday = birthday;
    
    UIImage *backgroundImage = (indexPath.row == 0) ? [UIImage imageNamed:@"table-row-background.png"] : [UIImage imageNamed:@"table-row-icing-background.png"];
    brTableCell.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue!");
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"BirthdayDetail"]){
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        BRDBirthday *birthday = [self.fetchedResultController objectAtIndexPath:selectedIndexPath];
        BRBirthdayDetailViewController *birthdayDetailViewController = segue.destinationViewController;
        birthdayDetailViewController.birthday = birthday;
    }else if ([identifier isEqualToString:@"AddBirthday"]){
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        BRDBirthday *birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
        [birthday updateWithDefaults];
        UINavigationController *navigationController = segue.destinationViewController;
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *)[navigationController topViewController];
        birthdayEditViewController.birthday = birthday;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSFetchedResultsController *)fetchedResultController{
    if(_fetchedResultController == nil){
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
        request.entity = entity;
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nextBirthday" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        request.sortDescriptors = sortDescriptors;
        self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultController.delegate = self;
        NSError *error = nil;
        if(![self.fetchedResultController performFetch:&error]){
            NSLog(@"Unresolved error %@, %@", error,[error userInfo]);
            abort();
        }
    }
    return _fetchedResultController;
}

-(void)setHasFriends:(BOOL)hasFriends{
    _hasFriends = hasFriends;
    self.importView.hidden = hasFriends;
    self.tableView.hidden = !hasFriends;
    
    if([self.navigationController topViewController] == self){
        [self.navigationController setToolbarHidden: !hasFriends animated:NO];
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
}

- (IBAction)importFromAddressBookTapped:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportAddressBook"];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)importFromFacebookTapped:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportFacebook"];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

-(void) handleCacheBirthdaysDidUpdate:(NSNotification *)notification {
    [self.tableView reloadData];
}
@end
