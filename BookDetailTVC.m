//
//  BookDetailTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookDetailTVC.h"
#import "AppDelegate.h"


@interface BookDetailTVC ()

@end

@implementation BookDetailTVC

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
    
    //ScrollView
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 1500)];
    
    self.titleField.text=self.currentBook.title;
    self.authorField.text=self.currentBook.author;
    self.notesField.text=self.currentBook.notes;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    self.dateAddedField.text=[formatter stringFromDate:self.currentBook.dateAdded];
    self.categoryLabel.text=self.currentBook.genre.genre;
    self.collectionLabel.text=self.currentBook.favorite.favorite;
    self.statusField.text=self.currentBook.status.readingStatus;
 
    
    
    self.statusMissingAlert.hidden=YES;
    self.bookTitleAlert.hidden=YES;
   
      }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([segue.identifier isEqualToString:@"addGenre"]) {
        
        BookGenreTVC *bgtvc=(BookGenreTVC *)[segue destinationViewController];
        bgtvc.delegate=self;
        
        bgtvc.managedObjectContext=myApp.managedObjectContext;
    }
    
    if ([segue.identifier isEqualToString:@"addCollection"]) {
        
        BookCollectionTVC *bctvc=(BookCollectionTVC *)[segue destinationViewController];
        bctvc.delegate=self;
        
        bctvc.managedObjectContext=myApp.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"addStatus"]) {
        BookStatusTVC *bstvc=(BookStatusTVC *)[segue destinationViewController];
        bstvc.delegate=self;
        bstvc.managedObjectContext=myApp.managedObjectContext;
    }
    
}
-(void)genreWasSelectedOnBookGenreTVC:(BookGenreTVC *)controller  {
    //Passing the selectedGenre's value to the BookDetailTVC and displaying it in genreTableViewCell.
    self.categoryLabel.text=controller.selectedGenre.genre;
    self.selectedGenre=controller.selectedGenre;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)bookGenreTVCCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)collectionWasSelectedOnBookCollectionTVC:(BookCollectionTVC *)controller{
    //Passing the selectedCollection's value to the BookDetailTVC and displaying it in collectionlTableViewCell.
    self.collectionLabel.text=controller.selectedCollection.favorite;
    self.selectedCollection=controller.selectedCollection;
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)bookCollectionTVCCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)statusWasSelectedOnBookStatusnTVC:(BookStatusTVC *)controller{
    //Passing the selectedStatus's value to the BookDetailTVC and displyaing it in the readingStatusTableView(Cell).
    self.selectedStatus=controller.selectedStatus;
    self.statusField.text=controller.selectedStatus.readingStatus;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)bookStatusTVCCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneEditingNotes:(id)sender {
    [self.notesField resignFirstResponder];
}
-(void)saveCurrentBook{
    
    [self.currentBook setTitle:self.titleField.text];
    [self.currentBook setAuthor:self.authorField.text];
    [self.currentBook setNotes:self.notesField.text];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [self.currentBook setDateAdded:[formatter dateFromString:self.dateAddedField.text]];
    
}
-(void)cancel:(id)sender{
    
    [self.managedObjectContext deleteObject:self.currentBook];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveToManagedObjectContext{
    
        NSError *error=nil;
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error %@",error);
        }
        
    
}

- (IBAction)saveNav:(id)sender {
   
    if ([self.titleField.text isEqualToString:@""]) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Title Missing" message:@"Please add a book title to save." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.bookTitleAlert.hidden=NO;
    } else if (self.selectedStatus.readingStatus==nil &&[self.statusField.text isEqualToString:@""]) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Status Missing" message:@"Please select your reading status." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.statusMissingAlert.hidden=NO;
        
    }else{
        [self saveCurrentBook];
        
        if (self.selectedGenre.genre!=nil) {
            [self.currentBook setGenre:self.selectedGenre];
        }else{
            [self.currentBook.genre setGenre:self.categoryLabel.text];
        }
        
        if (self.selectedCollection.favorite!=nil){
            [self.currentBook setFavorite:self.selectedCollection];
        }else {
            [self.currentBook.favorite setFavorite:self.collectionLabel.text];
        }
        
        if (self.selectedStatus.readingStatus!=nil) {
            [self.currentBook setStatus:self.selectedStatus];
        }else{
            [self.currentBook.status setReadingStatus:self.statusField.text];
        }
        
        [self.delegate bookDetailTVCDelegateSavePush:self];
        self.bookTitleAlert.hidden=YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}



- (IBAction)textResignFirstResponder:(UITextField *)sender {
    [self.titleField resignFirstResponder];
    [self.authorField resignFirstResponder];
    [self.dateAddedField resignFirstResponder];
    [self.notesField resignFirstResponder];
}
@end