//
//  WaitshowControl.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "WaitshowControl.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import "DetailViewController.h"

@interface WaitshowControl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *wsDateSource;
@property (nonatomic ,strong)NSMutableArray *wsTitleDateSource;

@end

@implementation WaitshowControl

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createTableView];
    }
    return self;
}
- (NSMutableArray *)wsDateSource{
    if (_wsDateSource ==nil) {
        _wsDateSource = [[NSMutableArray alloc] init];
    }
    return _wsDateSource;
}
- (NSMutableArray *)wsTitleDateSource{
    if (_wsTitleDateSource == nil) {
        _wsTitleDateSource = [[NSMutableArray alloc] init];
        
    }
    return _wsTitleDateSource;
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadData];
    }];
    [_tableView.mj_header beginRefreshing];
    [self addSubview:_tableView];

}
- (void)downloadData
{
    __weak WaitshowControl *weakSelf = self;
    
    [HttpRequestHelper waitShowControlRequestSuccess:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = responseObject;
            NSArray *comingMovieArray = dict[@"data"][@"coming"];
            for (NSDictionary *movieSection in comingMovieArray) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *comingMovieDict in movieSection[@"movies"]) {
                    MovieModel *movie = [[MovieModel alloc] initWithDict:comingMovieDict];
                    [array addObject:movie];
                }
                [self.wsDateSource addObject:array];
                [self.wsTitleDateSource addObject:movieSection[@"title"]];
            }
            [weakSelf.tableView reloadData];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error) {
        NSLog(@"下载待映影片错误:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}
#pragma mark - UITableView的相关代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // else if (tableView == _comingMovieTableView) {
    return self.wsTitleDateSource.count;
    // }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.wsDateSource[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return self.wsTitleDateSource[section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (CGFloat)tableVieheighw:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    MovieModel *item = self.wsDateSource[indexPath.section][indexPath.row];
    [cell configComingCell:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detal = [[DetailViewController alloc] init];
    MovieModel *model = _wsDateSource[indexPath.section][indexPath.row];
    detal.myId = model.myId;
    if (self.block) {
        self.block(model.myId);
    }
    
//    [self.navigationController pushViewController:detal animated:YES];
    
}

@end
