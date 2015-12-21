//
//  SpecialDetailViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailCell.h"
#import "DetailViewController.h"
@interface SpecialDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;

@property (nonatomic ,copy)NSString *titleSp;
@property (nonatomic ,copy)NSString *abstractSp;
@property (nonatomic ,copy)NSString *timeSp;

@end

@implementation SpecialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}
-(NSMutableArray*)dateSource{
    if (_dateSource == nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    __weak __typeof(self)weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
}
- (void)reloadData
{
    [_dateSource removeAllObjects];
    __weak SpecialDetailViewController *weakSelf = self;
    [HttpRequestHelper specialDetailControlWithMyId:_topicId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.timeSp = responseObject[@"data"][@"created"];
            weakSelf.titleSp = responseObject[@"data"][@"title"];;
            weakSelf.abstractSp = responseObject[@"data"][@"content"];
            NSArray *arrayd = responseObject[@"data"][@"movies"];
            for (NSDictionary *dict  in arrayd) {
                SpecialDetailModel *model = [[SpecialDetailModel alloc] initWithDict:dict];
                [weakSelf.dateSource addObject:model];
            }
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"error=%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
#pragma mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 111;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    SpecialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[SpecialDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.size = CGSizeMake(UIScreenWidth, 120);
    
    SpecialDetailModel *moedel  = _dateSource[indexPath.row];
    [cell configWithModel:moedel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    SpecialDetailModel*model = _dateSource[indexPath.row];
    detail.myId = model.myId;
    [self.navigationController pushViewController:detail animated:YES];
    
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
