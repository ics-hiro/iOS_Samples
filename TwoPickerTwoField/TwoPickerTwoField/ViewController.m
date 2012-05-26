//
//  ViewController.m
//  TwoPickerTwoField
//
//  Created by Hiroyuki Watanabe on 12/05/27.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIPickerView *picker1;
    UIPickerView *picker2;
    
    NSString *pic1_str;
    NSString *pic2_str;
}
@synthesize textField1;
@synthesize textField2;

- (void)viewDidLoad
{
    /*
     * テキストフィールドとピッカーにタグをつけるのが今回のポイントです。
     * まだ慣れてない人は、デリゲートを書くのを忘れがちなのでhファイルの<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>に注意
     * delegateにselfを指定することも忘れないこと。
     * UITextFieldDelegateを入れることでShouldBeginEditingを呼び出せる
     * ピッカーについて私が以前に書いた記事も参照してください。http://d.hatena.ne.jp/kazukingband/20120522/1337638966
     */
    
    
    [super viewDidLoad];
    textField1.delegate = self;
    textField2.delegate = self;
	textField1.tag = 1;
    textField2.tag = 2;
    
    picker1 = [[UIPickerView alloc] init];
    picker1.frame = CGRectMake(0, 460, 320, 216);
    picker1.showsSelectionIndicator = YES;
    picker1.delegate = self;
    picker1.dataSource = self;
    picker1.tag = 1;
    [self.view addSubview:picker1];
    
    picker2 = [[UIPickerView alloc] init];
    picker2.frame = CGRectMake(0, 460, 320, 216);
    picker2.showsSelectionIndicator = YES;
    picker2.delegate = self;
    picker2.dataSource = self;
    picker2.tag = 2;
    [self.view addSubview:picker2];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1) {
        NSLog(@"1");
        picker2.frame = CGRectMake(0, 460, 320, 216);
        
        [self showPicker1];
        
        //キーボードは表示させない
        return NO;
        
    }
    if (textField.tag == 2) {
        NSLog(@"2");
        picker1.frame = CGRectMake(0, 460, 320, 216);
        
        
        [self showPicker2];
        
        //キーボードは表示させない
        return NO;
    }
}

- (void)showPicker1 {
	//picker1が出てくる
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker1.frame = CGRectMake(0, 204, 320, 216); //picker1を呼び出します
	[UIView commitAnimations];
}

- (void)showPicker2 {
	//picker2が出てくる
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker2.frame = CGRectMake(0, 204, 320, 216); //picker2を呼び出します
	[UIView commitAnimations];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        return 3;
    }
    if (pickerView.tag == 2) {
        return 3;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        NSArray *arr = [[NSArray alloc] initWithObjects:@"絶対に",@"挫折しない",@"iPhoneアプリ開発入門",nil];
        pic1_str = [NSString stringWithFormat:@"%@",[arr objectAtIndex:row]];
        return pic1_str;
    }
    if (pickerView.tag == 2) {
        NSArray *arr = [[NSArray alloc] initWithObjects:@"勉強会も",@"やってるので",@"ご連絡ください",nil];
        pic2_str = [NSString stringWithFormat:@"%@",[arr objectAtIndex:row]];
        return pic2_str;
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        NSArray *arr = [[NSArray alloc] initWithObjects:@"絶対に",@"挫折しない",@"iPhoneアプリ開発入門",nil];
        pic1_str = [NSString stringWithFormat:@"%@",[arr objectAtIndex:row]];
        textField1.text = pic1_str;
    }
    if (pickerView.tag == 2) {
        NSArray *arr = [[NSArray alloc] initWithObjects:@"勉強会も",@"やってるので",@"ご連絡ください",nil];
        pic2_str = [NSString stringWithFormat:@"%@",[arr objectAtIndex:row]];
        textField2.text = pic2_str;
    }
}


- (void)viewDidUnload
{
    [self setTextField1:nil];
    [self setTextField2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
