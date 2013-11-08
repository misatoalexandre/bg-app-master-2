//
//  MenuSelectionViewController.m
//  Books
//
//  Created by Misato Tina Alexandre on 11/7/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "MenuSelectionViewController.h"
#import "BookListTVC.h"
#import "CollectionListTVC.h"
#import "GenreListTVC.h"
#import "AboutTVC.h"

@interface MenuSelectionViewController ()

@end

@implementation MenuSelectionViewController

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
    self.title=@"Book x Geek";

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toBooks"]) {
        BookListTVC *bltvc=(BookListTVC *)[segue destinationViewController];
        bltvc.managedObjectContext=self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"toCollections"]) {
        CollectionListTVC *cltvc=(CollectionListTVC *)[segue destinationViewController];
        cltvc.managedObjectContext=self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"toCategories"]) {
        GenreListTVC *gltvc=(GenreListTVC *)[segue destinationViewController];
        gltvc.managedObjectContext=self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"toAbout"]) {
        AboutTVC *atvc=(AboutTVC *)[segue destinationViewController];
        atvc.title=@"About";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
