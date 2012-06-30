//
//  PhotoViewController.m
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/13.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "PhotoViewController.h"
#import "DataModels.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
{
    @private
    NSMutableArray *titleArry;
    NSMutableArray *contentsArry;
}
@synthesize titleLabel;
@synthesize photoImage;
@synthesize row_num;

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
    
    titleArry = [[NSMutableArray alloc] init ];
    contentsArry = [[NSMutableArray alloc] init ];
    
    [DataModels selectTitle:titleArry];
    [DataModels selectContents:contentsArry];
    
    
    // 前のTableViewで選択した行に応じて表示させる
    titleLabel.text = [titleArry objectAtIndex:row_num];
    photoImage.image = [[UIImage alloc] initWithData:[contentsArry objectAtIndex:row_num]];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setPhotoImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
