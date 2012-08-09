//
//  MasterViewController.m
//  FlowerDetail
//
//  Created by Mason Mei on 8/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
@synthesize flowerData;
@synthesize flowerSections;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [self createFlowerData];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidUnload
{
    [self setFlowerData:nil];
    [self setFlowerSections:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.flowerSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.flowerData objectAtIndex:section]count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.flowerSections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flowerCell"];
//    cell.textLabel.text = @"Title String";
//    cell.detailTextLabel.text = @"Detail String";
//    cell.imageView.image = [UIImage imageNamed:@"MyPicture.png"];
    cell.textLabel.text=[[[self.flowerData objectAtIndex:indexPath.section]
                          objectAtIndex: indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text=[[[self.flowerData objectAtIndex:indexPath.section]
                                objectAtIndex: indexPath.row] objectForKey:@"url"];
    
    UIImage *flowerImage;
    flowerImage=[UIImage imageNamed:
                 [[[self.flowerData objectAtIndex:indexPath.section]
                   objectAtIndex: indexPath.row] objectForKey:@"picture"]];
    
    cell.imageView.image=flowerImage;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.detailItem = [[flowerData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.detailViewController = segue.destinationViewController;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

-(void)createFlowerData{
    NSMutableArray *redFlowers;
    NSMutableArray *blueFlowers;
    self.flowerSections = [[NSArray alloc] initWithObjects:@"Red Flowers", @"BlueFlowers", nil];
    redFlowers = [[NSMutableArray alloc]init];
    blueFlowers = [[NSMutableArray alloc]init];
    [redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Poppy",@"name",
						   @"poppy.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Poppy",@"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Tulip",@"name",
						   @"tulip.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Tulip",@"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Gerbera",@"name",
						   @"gerbera.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Gerbera",@"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Peony",@"name",
						   @"peony.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Peony",@"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Rose",@"name",
						   @"rose.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Rose",@"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Hollyhock",@"name",
						   @"hollyhock.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Hollyhock",
						   @"url",nil]];
	[redFlowers addObject:[[NSDictionary alloc]
						   initWithObjectsAndKeys:@"Straw Flower",@"name",
						   @"strawflower.png",@"picture",
						   @"http://en.wikipedia.org/wiki/Strawflower",
						   @"url",nil]];
	
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Hyacinth",@"name",
							@"hyacinth.png",@"picture",
							@"http://en.m.wikipedia.org/wiki/Hyacinth_(flower)",
							@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Hydrangea",@"name",
							@"hydrangea.png",@"picture",
							@"http://en.m.wikipedia.org/wiki/Hydrangea",
							@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Sea Holly",@"name",
							@"sea holly.png",@"picture",
							@"http://en.wikipedia.org/wiki/Sea_holly",
							@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Grape Hyacinth",@"name",
							@"grapehyacinth.png",@"picture",
							@"http://en.wikipedia.org/wiki/Grape_hyacinth",
							@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Phlox",@"name",
							@"phlox.png",@"picture",
							@"http://en.wikipedia.org/wiki/Phlox",@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Pin Cushion Flower",@"name",
							@"pincushionflower.png",@"picture",
							@"http://en.wikipedia.org/wiki/Scabious",
							@"url",nil]];
	[blueFlowers addObject:[[NSDictionary alloc]
							initWithObjectsAndKeys:@"Iris",@"name",
							@"iris.png",@"picture",
							@"http://en.wikipedia.org/wiki/Iris_(plant)",
							@"url",nil]];
    self.flowerData = [[NSArray alloc] initWithObjects:redFlowers, blueFlowers, nil];
}

@end
