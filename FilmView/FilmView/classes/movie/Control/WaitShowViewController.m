//
//  WaitShowViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/11.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "WaitShowViewController.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import "DetailViewController.h"

@interface WaitShowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *wsDateSource;
@property (nonatomic ,strong)NSMutableArray *wsTitleDateSource;



@end

@implementation WaitShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self createTableView];
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
- (void)setNav{
    [self addtitleWithName:@"待映"];
    
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadData];
    }];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
}

// 用AFNetWorking实现get请求
- (void)downloadData
{
    __weak WaitShowViewController *weakSelf = self;
    
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
    detal.moedel = model;
    [self.navigationController pushViewController:detal animated:YES];
    
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
