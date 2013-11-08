//
//  EditBookVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 11/5/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookDetailTVC.h"

@interface EditBookVC : UIViewController<BookDetailTVCDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *collection;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) Book *currentBook;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)editButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;
@end
