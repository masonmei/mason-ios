//
//  BRImportViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/30/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRImportViewController.h"
#import "BRBrithdayTableViewCell.h"
#import "BRDBirthdayImport.h"
#import "BRDModel.h"

@interface BRImportViewController ()
@property (nonatomic, strong) NSMutableDictionary *selectedIndexPathToBirthday;
@end

@implementation BRImportViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapImportButton:(id)sender {
    NSArray *birthdaysToImport = [self.selectedIndexPathToBirthday allValues];
    [[BRDModel sharedInstance] importBirthdays:birthdaysToImport];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSelectAllButton:(id)sender {
    BRDBirthdayImport *birthdayImport;
    
    int maxloop = [self.birthdays count];
    
    NSIndexPath *indexPath;
    
    for (int i = 0; i < maxloop; i++) {
        birthdayImport = self.birthdays[i];
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        self.selectedIndexPathToBirthday[indexPath] = birthdayImport;
    }
    
    [self.tableView reloadData];
    [self updateImportButton];
}

- (IBAction)didTapSelectNoneButton:(id)sender {
    [self.selectedIndexPathToBirthday removeAllObjects];
    [self.tableView reloadData];
    [self updateImportButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.birthdays count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    BRDBirthdayImport *birthdayImport = self.birthdays[indexPath.row];
    
    BRBrithdayTableViewCell *brTableCell = (BRBrithdayTableViewCell *) cell;
    
    brTableCell.birthdayImport = birthdayImport;
    
    UIImage *backgroundImage = (indexPath.row == 0) ? [UIImage imageNamed:@"table-row-background.png"] : [UIImage imageNamed:@"table-row-icing-background.png"];
    
    brTableCell.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    
    [self updateAccessoryForTableCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isSelected = [self isSelectedAtIndexPath:indexPath];
    
    BRDBirthdayImport *birthdayImport = self.birthdays[indexPath.row];
    
    if(isSelected){
        [self.selectedIndexPathToBirthday removeObjectForKey:indexPath];
    } else {
        [self.selectedIndexPathToBirthday setObject:birthdayImport forKey:indexPath];
    }
    
    [self updateAccessoryForTableCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
    [self updateImportButton];
}

-(void) updateAccessoryForTableCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *)indexPath{
    UIImageView *imageView;
    
    if([self isSelectedAtIndexPath:indexPath]){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-import-selected.png"]];
    } else {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-import-not-selected.png"]];
    }
    cell.accessoryView = imageView;
}

-(void) updateImportButton{
    self.importButton.enabled = [self.selectedIndexPathToBirthday count] > 0;
}

-(BOOL) isSelectedAtIndexPath:(NSIndexPath *)indexPath{
    return _selectedIndexPathToBirthday[indexPath]? YES : NO;
}

-(NSMutableDictionary *)selectedIndexPathToBirthday{
    if(_selectedIndexPathToBirthday == nil){
        _selectedIndexPathToBirthday = [NSMutableDictionary dictionary];
    }
    return _selectedIndexPathToBirthday;
}
@end
