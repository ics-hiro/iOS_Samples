//
//  ViewController.m
//  CopyPasteSample
//
//  Created by Hiroyuki Watanabe on 12/05/23.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize copytf;
@synthesize pastetf;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCopytf:nil];
    [self setPastetf:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pushcopy:(id)sender {
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setValue:copytf.text forPasteboardType:@"public.utf8-plain-text"];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:copytf.text message:@"コピーしました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [av show];
}
@end
