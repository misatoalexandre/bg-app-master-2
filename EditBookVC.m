//
//  EditBookVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 11/5/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "EditBookVC.h"
#import "BookDetailTVC.h"

@interface EditBookVC ()

@end

@implementation EditBookVC

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
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 1500)];
    
    [self fillInfo];
    
}
-(void)fillInfo{
    self.bookTitle.text=self.currentBook.title;
    self.author.text=self.currentBook.author;
    self.notes.text=self.currentBook.notes;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    self.date.text=[formatter stringFromDate:self.currentBook.dateAdded];
    self.category.text=self.currentBook.genre.genre;
    self.collection.text=self.currentBook.favorite.favorite;
    self.status.text=self.currentBook.status.readingStatus;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"edit"]){
    BookDetailTVC *bdtvc=(BookDetailTVC *)[segue destinationViewController];
    bdtvc.currentBook=self.currentBook;
    bdtvc.delegate=self;
    }
}

- (IBAction)editButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"edit" sender:self];
}

- (IBAction)shareButtonPressed:(id)sender {
    
    NSString *title= [NSString stringWithFormat:@" Title: %@", self.bookTitle.text];
    NSString *author=[NSString stringWithFormat:@"By: %@", self.author.text];
    NSString *date=[NSString stringWithFormat:@"Listed on: %@", self.date.text];
    NSString *status=[NSString stringWithFormat:@"Status: %@", self.status.text];
    NSString *category=[NSString stringWithFormat:@"Category: %@", self.category.text];
    NSString *collection=[NSString stringWithFormat:@"Collection: %@", self.collection.text];
    NSString *notes=[NSString stringWithFormat:@"Notes: %@", self.notes.text];
    
    NSMutableArray *activitiesItem=[[NSMutableArray alloc]initWithObjects:title, nil];
    
    if (![self.currentBook.author isEqualToString:@""]) {
        [activitiesItem addObject:author];
    }
    [activitiesItem addObject:status];
    if (self.currentBook.genre.genre!=nil) {
        [activitiesItem addObject:category];
    }
    if (self.currentBook.favorite.favorite!=nil) {
        [activitiesItem addObject:collection];
    }
    if (![self.currentBook.notes isEqualToString:@""]) {
        [activitiesItem addObject:notes];
    }
    [activitiesItem addObject:date];
    
    
    UIActivityViewController *avc=[[UIActivityViewController alloc]initWithActivityItems:activitiesItem applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
  }
-(void)save{
    NSError *error=nil;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error %@",error);
    }
    
    
}

-(void)bookDetailTVCDelegateSavePush:(BookDetailTVC *)controller{
    [self save];
    
    [self fillInfo];
    
}
@end
