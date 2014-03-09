//
//  WebViewController.m
//  question
//
//  Created by imaimiami on 2014/03/09.
//  Copyright (c) 2014年 PLASTICA ROMANTICA. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

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
	
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
