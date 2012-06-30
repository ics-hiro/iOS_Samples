//
//  NewViewController.m
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/13.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "NewViewController.h"
#import "DataModels.h"


@interface NewViewController ()

@end

@implementation NewViewController
{
    @private
    NSData *imageData;
}
@synthesize btn_select;
@synthesize memoField;
@synthesize image_view;

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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save_memo_photo)];
    self.navigationItem.rightBarButtonItem = button;
    
    memoField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [memoField resignFirstResponder];
    return YES;
}

- (void)viewDidUnload
{
    [self setBtn_select:nil];
    [self setMemoField:nil];
    [self setImage_view:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (IBAction)selectPhoto:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library",nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentModalViewController:picker animated:YES];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    // オリジナル画像を取得する
    UIImage*    originalImage;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    // グラフィックスコンテキストを作る
    CGSize  size = { 320, 400 };
    UIGraphicsBeginImageContext(size);
    
    // 画像を縮小して描画する
    CGRect  rect;
    rect.origin = CGPointZero;
    rect.size = size;
    [originalImage drawInRect:rect];
    
    // 描画した画像を取得する
    UIImage*    shrinkedImage;
    shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image_view.image = shrinkedImage;
    
    // データベースに入れるためにNSDataに変換、保存のときに使う
    imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(shrinkedImage, 0.8)];
    
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    if(error){
        // 保存失敗時
    }else{
        // 保存成功時
    }
}

//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
	// 何かの処理
}

- (void)save_memo_photo
{
    // メモ、写真を選択してないと進めない
    if ([memoField.text length] > 0 && [imageData length] != 0) {
        
        [DataModels insertTitle:memoField.text Contents:imageData];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"写真とメモ" message:@"写真を選んでメモを書いてね" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
    }
    
}



@end
