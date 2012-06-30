//
//  NewViewController.h
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/13.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

- (IBAction)selectPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet UITextField *memoField;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@end
