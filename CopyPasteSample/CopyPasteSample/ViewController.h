//
//  ViewController.h
//  CopyPasteSample
//
//  Created by Hiroyuki Watanabe on 12/05/23.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *copytf;
@property (weak, nonatomic) IBOutlet UITextField *pastetf;
- (IBAction)pushcopy:(id)sender;
@end
