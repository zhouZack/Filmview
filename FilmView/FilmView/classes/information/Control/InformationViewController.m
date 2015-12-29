//
//  InformationViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationCell.h"
#import "InformationModel.h"
#import "InDetailViewController.h"

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *dataSoure;

@property (nonatomic ,assign)NSInteger integerIn;
@end

@implementation InformationViewController

- (NSMutableArray*)dataSoure
{
    if (_dataSoure==nil) {
        _dataSoure = [[NSMutableArray alloc] init];
    }
    return _dataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [self setNav];
    [self createTableView];
}
-(void)setNav{
    [self addtitleWithName:@"影讯"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:NO frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    __weak __typeof(self)weakSelf=self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.integerIn = 0;
        [weakSelf reloadDate];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.integerIn +=10;
        [weakSelf reloadDate];
    }];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
}
- (void)reloadDate
{
    __weak __typeof(self)weakSelf=self;
    if (self.integerIn ==0) {
        [self.dataSoure removeAllObjects];
    }
    [HttpRequestHelper informationControlWithInteger:_integerIn success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"data"][@"feeds"];
            for (NSDictionary *dict in array) {
                if ([dict[@"feedType"] isEqualToNumber:@7]) {
                    InformationModel *model = [[InformationModel alloc] initWithDict:dict];
                    [weakSelf.dataSoure addObject:model];

                }
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma  mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSoure.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell  ==nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    InformationModel *model  = _dataSoure[indexPath.row];
    [cell configWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationModel *model = _dataSoure[indexPath.row];
    NSString *string = model.url;
    NSLog(@"%@",string);
    NSRange range = [string rangeOfString:@"?id="];
    NSString *idS1tring = [string substringFromIndex:range.location+range.length];
    InDetailViewController *detail = [[InDetailViewController alloc] init];
    
    detail.myId = idS1tring;
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)changeLeft{
    [self changeLeftList];
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
