//
//  DataModels.h
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/26.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModels : NSObject
+ (void)insertTitle:(NSString *)title Contents:(NSData *)contents;
+ (NSMutableArray *)selectTitle:(NSMutableArray *)array;
+ (NSMutableArray *)selectContents:(NSMutableArray *)array;
+ (void)drop_table;
@end
