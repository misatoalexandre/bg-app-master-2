//
//  BookCollectionTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookCollectionTVC.h"
#import "BookCollectionDetailTVC.h"

@interface BookCollectionTVC ()

@end

@implementation BookCollectionTVC

@synthesize fetchedResultsController=_fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-Default value setting
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (![[self.fetchedResultsController fetchedObjects]count] >0) {
        [self importCoreDataDefaultsCollection];
    }else{
        
    }
}
-(void) insertFavoriteWithCollection:(NSString *)collectionTitle{
    Favorite *favorite=[NSEntityDescription insertNewObjectForEntityForName:@"Favorite"
                                               inManagedObjectContext:self.managedObjectContext];
    favorite.favorite=collectionTitle;
    [self.managedObjectContext save:nil];
}
-(void)importCoreDataDefaultsCollection{
    [self insertFavoriteWithCollection:@"Timeless Classic"];
    [self insertFavoriteWithCollection:@"Recommended"];
    [self insertFavoriteWithCollection:@"Must Read"];
    [self insertFavoriteWithCollection:@"Best Books of The Year"];
    [self insertFavoriteWithCollection:@"All time favorites"];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error=nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error %@", error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ViewDidLoad on Collection failed" message:@"Collection page did not load" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Prepare for segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addCollection"]) {
        BookCollectionDetailTVC *bookCollectiondtvc=(BookCollectionDetailTVC *)[segue destinationViewController];
        bookCollectiondtvc.delegate=self;
        
        Favorite *newFavorite=(Favorite *)[NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:self.managedObjectContext];
        bookCollectiondtvc.currentFavorite=newFavorite;

    }else{
        
    }
    
    }

-(void)bookCollectionDetailTVCDelegateSave{
    NSError *error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in saving new genre. %@", error);
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)bookCollectionDetailTVCDelegateCancel:(Favorite *)favoriteToDelete{
    [self.managedObjectContext deleteObject:favoriteToDelete];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> secInfo=[[self.fetchedResultsController sections]objectAtIndex:section];
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Favorite *favorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=favorite.favorite;
    unsigned int bookCount=[favorite.favoriteBooks count];
    
    if (bookCount>1) {
        NSString *bookNumber=[NSString stringWithFormat:@"%d books",bookCount];
        cell.detailTextLabel.text=bookNumber;
    }else{
        NSString *bookNumber=[NSString stringWithFormat:@"%d book",bookCount];
        cell.detailTextLabel.text=bookNumber;
    }
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCollection=[self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate collectionWasSelectedOnBookCollectionTVC:self];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context=self.managedObjectContext;
        Favorite *favorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:favorite];
        
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Error %@", error);
        }
    }
    
}

#pragma mark-Fetched Results Controller Section
-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController!=nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"favorite"
                                                                   ascending:NO];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate=self;
    return _fetchedResultsController;
    
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:{
            Favorite *changedFavorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text=changedFavorite.favorite;
        }
            
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
}

- (IBAction)cancel:(id)sender {
    [self.delegate bookCollectionTVCCancel];
}
@end
