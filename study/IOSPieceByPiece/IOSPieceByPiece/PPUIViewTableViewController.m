//
//  PPUIViewTableViewController.m
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/14/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "PPUIViewTableViewController.h"

@interface PPUIViewTableViewController ()

@end

@implementation PPUIViewTableViewController

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

    self.times = [NSMutableArray arrayWithArray: @[[NSDate date]]];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.times.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.times[indexPath.row]];
    
    return cell;
}


-(void)handleRefresh
{
    int64_t delayInSeconds = 1.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.times addObject:[NSDate date]];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

@end
