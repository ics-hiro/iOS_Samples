//
//  ViewController.m
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/13.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "ViewController.h"
#import "PhotoViewController.h"
#import "NewViewController.h"
#import "DataModels.h"

@interface ViewController ()

// 別クラスとアクセスはしないので、プラベートに宣言
@property (retain, nonatomic) UITableView *tableView;

@end

@implementation ViewController
{
    @private
    NSMutableArray *titleArry;
    NSMutableArray *contentsArry;
}
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Photo Library";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(make_new_contents)];
    self.navigationItem.rightBarButtonItem = button;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, 320, 460-44);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 90.0;
    [self.view addSubview:_tableView];
    
}

- (void)make_new_contents
{
    NewViewController *nvc = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:nvc animated:YES];
}


// Viewが呼ばれるたびにデータとテーブルの更新
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleArry = [[NSMutableArray alloc] init ];
    contentsArry = [[NSMutableArray alloc] init ];
    
    [DataModels selectTitle:titleArry];
    [DataModels selectContents:contentsArry];
    
    
    [_tableView reloadData]; //テーブルをリロードして更新
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArry.count;
}
 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    //セルに表示する内容
    cell.textLabel.text = [titleArry objectAtIndex:indexPath.row];
    cell.imageView.image = [[UIImage alloc] initWithData:[contentsArry objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルの選択を解除する
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i = 0; i < titleArry.count; i++) {
        if (indexPath.row == i) {
            PhotoViewController *bvc = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
            bvc.row_num = i; // どの行を選んだのか、次のViewControllerに値を受け渡ししている。
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( editingStyle == UITableViewCellEditingStyleDelete )
	{
		[self removeContents:indexPath];
	}
}

- (void)removeContents:(NSIndexPath*)indexPath
{
    //選択したrow番目の配列要素を削除する。
    NSInteger row = [indexPath row];
    [titleArry removeObjectAtIndex: row];
    [contentsArry removeObjectAtIndex: row];
    
    //セルが消えるアニメーション       
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
    
    
    //いったん、テーブルの中身を削除してしまって、新しいのをごっそりいれる。
    [DataModels drop_table];
    
    
    //titleArryとcontentsArryは、すでに要素が削除されていて、残りの要素がつめられている状態。そしてインサートしている。
    for (int i = 0; i < titleArry.count; i++ ) {
        [DataModels insertTitle:[titleArry objectAtIndex:i] Contents:[contentsArry objectAtIndex:i]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

@end
