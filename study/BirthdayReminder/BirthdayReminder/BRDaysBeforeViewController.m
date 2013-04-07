//
//  BRDaysBeforeViewController.m
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRDaysBeforeViewController.h"
#import "BRDSettings.h"

@interface BRDaysBeforeViewController ()

@end

@implementation BRDaysBeforeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app-background.png"]];
    [self.tableView setBackgroundView:backgroundView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[BRDSettings sharedInstance] titleForDaysBefore:indexPath.row];
    
    cell.accessoryType = ([BRDSettings sharedInstance].daysBefore == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BRDaysBeforeTypeThreeWeeks + 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [BRDSettings sharedInstance].daysBefore){
        [tableView  deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:[BRDSettings sharedInstance].daysBefore inSection:0];
    [BRDSettings sharedInstance].daysBefore = indexPath.row;
    [tableView reloadRowsAtIndexPaths:@[oldIndexPath, indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
