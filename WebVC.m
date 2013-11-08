//
//  WebVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 11/7/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@end

@implementation WebVC

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
  
    NSURL *url=[NSURL URLWithString:self.fullURL];
    NSURLRequest *requestobj=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestobj];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
