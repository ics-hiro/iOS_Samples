//
//  ViewController.h
//  ShowPicker
//
//  Created by Hiroyuki Watanabe on 12/05/22.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    UIPickerView *picker;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end
