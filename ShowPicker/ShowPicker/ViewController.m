//
//  ViewController.m
//  ShowPicker
//
//  Created by Hiroyuki Watanabe on 12/05/22.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label = _label;
@synthesize textField = _textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	picker = [[UIPickerView alloc] init];
    picker.frame = CGRectMake(0, 420, 320, 216);
    picker.showsSelectionIndicator = YES;
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    
    _textField.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //テキストフィールドの編集を始めるときに、ピッカーを呼び出す。
    [self showPicker];
    
    //キーボードは表示させない
    return NO;
}

- (void)showPicker {
	//ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, 204, 320, 216);
	[UIView commitAnimations];
	
	//ナビゲーションバーの右上にdoneボタンを設置する
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:done animated:YES];
    }	
}

- (void)done:(id)sender {
	//ピッカーをしまう
	[self hidePicker];
	
	//doneボタンを消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)hidePicker {
	//ピッカーを下に隠すアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, 420, 320, 216);
	[UIView commitAnimations];
    
	//doneボタンを消す
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _label.text = [NSString stringWithFormat:@"%d",row];
    _textField.text = [NSString stringWithFormat:@"%d",row];
}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
