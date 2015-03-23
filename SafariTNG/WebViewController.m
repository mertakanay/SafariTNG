//
//  ViewController.m
//  SafariTNG
//
//  Created by Mert Akanay on 11.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    //to set up a delegate for activity controller. also we need to define delegate at interface above.

    self.activityIndicator.hidesWhenStopped=YES;

    [self performLoadRequestWithString:@"http://www.theverge.com"];

}

- (void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark -UIWebViewDelegate Protocols
//sadece bölümleri ayırmaya yarıyor. Kompleks kodlarda çok kullanılır

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed to load webpage" message:error.localizedDescription delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try Again", nil];
    [alertView show];
}

#pragma mark -UITextFieldDelegate Protocols

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performLoadRequestWithString:textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performLoadRequestWithString:@"http://www.theverge.com"];
    }
}


@end
