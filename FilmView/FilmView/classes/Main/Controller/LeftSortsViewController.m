//
//  LeftSortsViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/8.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "CollectViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface LeftSortsViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftbackiamge"]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageBack"]];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    [self createTableView];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.width = 200;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row ==0) {
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.row ==1){
        cell.textLabel.text = @"清除缓存";
        //!!!: 清除缓存
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM", [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (indexPath.row ==0){
        [app.testVC2 closedLeftView];
       CollectViewController *collect = [[CollectViewController alloc] init];
        [(UINavigationController *)app.mainTabBarController.selectedViewController pushViewController:collect animated:YES];
    }else{
        [[SDImageCache sharedImageCache] clearDisk];
        [_tableView reloadData];

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 170;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 170, UIScreenWidth);
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
