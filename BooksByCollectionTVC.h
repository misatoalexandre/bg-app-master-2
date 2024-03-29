//
//  BooksByCollectionTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/23/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Favorite.h"
#import "Book.h"


@interface BooksByCollectionTVC : UITableViewController<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController   *fetchedResultsController;
@property (strong, nonatomic) Favorite *selectedFavorite;
@property (strong, nonatomic) Book *currentBook;

@end
