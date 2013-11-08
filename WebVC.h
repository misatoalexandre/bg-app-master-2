//
//  WebVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 11/7/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *fullURL;
@end
