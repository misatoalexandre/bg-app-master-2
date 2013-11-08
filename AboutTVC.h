//
//  AboutTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 11/7/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutTVC : UITableViewController<MFMailComposeViewControllerDelegate>

- (IBAction)sendEmail:(id)sender;
- (IBAction)openWeb:(id)sender;

@end
