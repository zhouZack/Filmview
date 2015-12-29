//
//  SubjectViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SpecialTopicViewController.h"
#import "SepcialTopicModel.h"
#import "SepcialTopicCell.h"
#import "SpecialDetailViewController.h"
#import "DetailViewController.h"
@interface SpecialTopicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,assign)NSInteger      integer;
@end

@implementation SpecialTopicViewController

- (NSMutableArray*)dateSource{
    if (_dateSource == nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self setNav];
    [self createTableView];

}
- (void)setNav{
    [self addtitleWithName:@"专题"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:NO frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
}
-(void)changeLeft{
    [self changeLeftList];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    __weak __typeof(self)weakSelf = self;
    _tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
        weakSelf.integer = 0;
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.integer+=10;
        [weakSelf reloadData];
        
    }];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
    
    
}
- (void)reloadData
{
    __weak __typeof(self)weakSelf = self;
    if (_integer ==0) {
        [self.dateSource removeAllObjects];
    }
    
    [HttpRequestHelper specialTopicControlWithInteger:_integer success:^(id responseObject) {
        NSArray *array = responseObject[@"data"];
        
        for (NSDictionary *dict in array) {
            SepcialTopicModel *model =[[SepcialTopicModel alloc] initWithDict:dict];
            [weakSelf.dateSource addObject:model];
            NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
            NSArray *array2 = dict[@"movies"];
            for (NSDictionary *dict in array2) {
                topicMovieModel*model = [[topicMovieModel alloc] initWithDict:dict];
                [mutableArr addObject:model];
            }
            model.topicArray = mutableArr;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } Failure:^(NSError *error) {
        NSLog(@"error =%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    SepcialTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SepcialTopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    SepcialTopicModel *model = _dateSource[indexPath.row];
    [cell config:model];
    __weak __typeof(self)weakSelf = self;
    cell.block = ^(NSString*str)
    {
        DetailViewController *ctrl = [[DetailViewController alloc] init];
        ctrl.myId = str;
        [weakSelf.navigationController pushViewController:ctrl animated:YES];
    };
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialDetailViewController *detail = [[SpecialDetailViewController alloc] init];
    SepcialTopicModel*model = _dateSource[indexPath.row];
    detail.topicId = model.myId;
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
