//
//  PhotoViewController.h
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/13.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController 
@property (nonatomic,assign) NSInteger row_num;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@end
