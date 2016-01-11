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
@property (nonatomic ,assign) CGFloat heighHeader;



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
    _heighHeader=150;
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
        [weakSelf CCCCC];
        [weakSelf.tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"error=%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)CCCCC
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 300)];
    UILabel *title = [ToolUtil labelwithFrame:CGRectMake(20, 25, UIScreenWidth-20, 25) font:23 text:self.titleSp color:[UIColor blackColor]];
    title.textAlignment = NSTextAlignmentLeft;
    [head addSubview:title];
    
    UILabel *time = [ToolUtil labelwithFrame:CGRectMake(20, title.bottom+15, 150, 15) font:13 text:self.timeSp color:[UIColor colorWithWhite:0.4 alpha:1]];
    title.textAlignment = NSTextAlignmentLeft;
    [head addSubview:time];
    
    CGSize contentSize = [ToolUtil labelAutoCalculateRectWith:self.abstractSp font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(UIScreenWidth - 30*kRatio, CGFLOAT_MAX)];
    
    UILabel *describe = [ToolUtil labelwithFrame:CGRectMake(20, time.bottom, contentSize.width, contentSize.height) font:15 text:self.abstractSp color:[UIColor colorWithWhite:0.4 alpha:1]];
    describe.textAlignment = NSTextAlignmentLeft;
    describe.numberOfLines = 0;
    [head addSubview:describe];
    describe.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    head.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
    CGRect frame = head.frame;
    frame.size.height = describe.bottom+10;
    head.frame = frame;
    _heighHeader = describe.bottom+10;

    
    
}
#pragma mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateSource.count;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 300)];
    head.backgroundColor = [UIColor whiteColor];
    UILabel *title = [ToolUtil labelwithFrame:CGRectMake(20, 25, UIScreenWidth-20, 25) font:23 text:self.titleSp color:[UIColor blackColor]];
    title.textAlignment = NSTextAlignmentLeft;
    [head addSubview:title];

    UILabel *time = [ToolUtil labelwithFrame:CGRectMake(20, title.bottom+15, 150, 15) font:13 text:self.timeSp color:[UIColor colorWithWhite:0.4 alpha:1]];
    title.textAlignment = NSTextAlignmentLeft;
    [head addSubview:time];
    
    CGSize contentSize = [ToolUtil labelAutoCalculateRectWith:self.abstractSp font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(UIScreenWidth - 30*kRatio, CGFLOAT_MAX)];
    
    UILabel *describe = [ToolUtil labelwithFrame:CGRectMake(20, time.bottom, contentSize.width, contentSize.height) font:15 text:self.abstractSp color:[UIColor colorWithWhite:0.4 alpha:1]];
    describe.textAlignment = NSTextAlignmentLeft;
    describe.numberOfLines = 0;
    [head addSubview:describe];
    CGRect frame = head.frame;
    frame.size.height = describe.bottom+10;
    head.frame = frame;
    _heighHeader = describe.bottom+10;
    NSLog(@"11111=%lf",_heighHeader);
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _heighHeader;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
