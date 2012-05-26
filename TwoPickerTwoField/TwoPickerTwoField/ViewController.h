//
//  ViewController.h
//  TwoPickerTwoField
//
//  Created by Hiroyuki Watanabe on 12/05/27.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@end
