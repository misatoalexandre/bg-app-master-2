//
//  AboutTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 11/7/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "AboutTVC.h"
#import "WebVC.h"

@interface AboutTVC ()

@end

@implementation AboutTVC

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebVC *webvc=(WebVC *)[segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"toPrivacy"]) {
        NSString *privacyURL=@"http://www.applicationprivacy.org/do-tools/privacy-policy-generator/";
       webvc.fullURL=privacyURL;
    }
    if ([segue.identifier isEqualToString:@"toTerms"]) {
        NSString *termsURL=@"http://www.npr.org/about-npr/179876898/terms-of-use";
       webvc.fullURL=termsURL;
    }

}

- (IBAction)sendEmail:(id)sender {
    NSString *emailTitle=@"Hello Misato,";
    NSString *message=@"";
    NSArray *receivers=[NSArray arrayWithObjects:@"contact@bookxgeek.com", nil];
    
    MFMailComposeViewController *mc=[[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate=self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:message isHTML:NO];
    [mc setToRecipients:receivers];
    
    [self presentViewController:mc animated:YES completion:nil];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail Cancelled.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail Saved.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail Sent.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openWeb:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bookxgeek.com"]];

}
@end
