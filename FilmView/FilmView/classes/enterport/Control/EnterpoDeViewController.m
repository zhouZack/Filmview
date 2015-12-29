//
//  EnterportDetialViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "EnterpoDeViewController.h"
#import "EnterPoCell.h"
#import "EnterPoModel.h"
#import "DetailViewController.h"
@interface EnterpoDeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,assign)NSInteger integerEn;


@end

@implementation EnterpoDeViewController

- (NSMutableArray*)dateSource{
    if (_dateSource == nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createTableView];
    
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    __weak __typeof(self)weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.integerEn = 0;
        [weakSelf reloadDate];
        
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.integerEn +=20;
        [weakSelf reloadDate];
    }];
    
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
    
}
- (void)reloadDate
{
    if (self.integerEn ==0) {
        [self.dateSource removeAllObjects];
    }
    __weak __typeof(self)weakSelf = self;
    [HttpRequestHelper enterPortDetailWithParameter1:self.parameter1 Parameter2:self.parameter2 Parameter3:self.parameterNum MyId:_integerEn success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSArray*arraydate = responseObject[@"list"];
            for (NSDictionary *dict in arraydate) {
                EnterPoModel *model = [[EnterPoModel alloc] initWith:dict];
                [weakSelf.dateSource addObject:model];
            }
            
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSLog( @"error=%@",error);
    }];
    
}


#pragma mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    EnterPoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[EnterPoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    EnterPoModel *model = _dateSource[indexPath.row];
    [cell config:model];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *ctrl = [[DetailViewController alloc] init];
    EnterPoModel *model = _dateSource[indexPath.row];
    ctrl.myId = model.myId;
    [self.navigationController pushViewController:ctrl animated:YES];
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
