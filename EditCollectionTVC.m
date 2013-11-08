//
//  EditCollectionTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/23/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "EditCollectionTVC.h"
#import "AppDelegate.h"
@interface EditCollectionTVC ()

@end

@implementation EditCollectionTVC

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
    self.collectionField.text=self.selectedCollection.favorite;
    self.saveBtn.hidden=YES;
    [self.collectionField setUserInteractionEnabled:NO];
    [self.tableViewCell setHighlighted:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


- (IBAction)edit:(id)sender {
    //Button states
    self.editBtn.hidden=YES;
    self.editBtn.userInteractionEnabled=NO;
    self.saveBtn.hidden=NO;
    self.saveBtn.userInteractionEnabled=YES;
    self.tableViewCell.highlighted=YES;
    
    //Text field states.
    self.collectionField.userInteractionEnabled=YES;
    [self.collectionField setClearButtonMode:UITextFieldViewModeAlways];
    
    //Table View Cell State
    self.tableViewCell.highlighted=YES;
    
}

- (IBAction)save:(id)sender {
    //Button States
    self.editBtn.hidden=NO;
    self.editBtn.userInteractionEnabled=YES;
    self.saveBtn.hidden=YES;
    self.saveBtn.userInteractionEnabled=NO;
    self.tableViewCell.highlighted=NO;
    
    //Text field states
    self.collectionField.userInteractionEnabled=NO;
    [self.collectionField setClearButtonMode:UITextFieldViewModeNever];
    
    //Table view cell states
    self.tableViewCell.highlighted=NO;
  
   //save the edited collection.
   [self.selectedCollection setFavorite:self.collectionField.text];
    AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myApp saveContext];
    
    NSString *newGenre=[NSString stringWithFormat:@"Category name was successfully updated to %@", self.selectedCollection.favorite];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Collection name updated!" message:newGenre delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.collectionField resignFirstResponder];
}

- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}


@end
