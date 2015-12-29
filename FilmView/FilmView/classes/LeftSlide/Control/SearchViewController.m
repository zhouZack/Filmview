//
//  SearchViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewCell.h"
#import "SearchModel.h"
#import "DetailViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,strong)UISearchBar *searchBaa;
@property (nonatomic ,strong)UISearchBar *searchBaa2;
@property (nonatomic ,strong)UISearchBar *searchBaa3;
@property (nonatomic ,strong)UISearchBar *searchBaa4;

@end

@implementation SearchViewController

- (NSMutableArray*)dateSource
{
    if (_dateSource == nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self createSearchBar];
    [self createTableView];
    
}


- (void)createSearchBar
{
    _searchBaa = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, UIScreenWidth, 44)];
    _searchBaa.delegate = self;
    _searchBaa.barStyle = UIBarStyleDefault;
    _searchBaa.showsCancelButton = YES;
    _searchBaa.placeholder = @"找电影";
    for (UIView *view in _searchBaa.subviews[0].subviews){
        if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")])
        {
            UIButton * btn = (UIButton*)view;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    self.navigationItem.titleView = _searchBaa;
    self.navigationItem.hidesBackButton = YES;
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
}
#pragma mark-UISearchBar代理协议
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.dateSource removeAllObjects];
    __weak __typeof(self)weakSelf = self;
    [HttpRequestHelper searchControlWithName:searchBar.text success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *arrayD = responseObject[@"list"];
            for (NSDictionary *dict in arrayD) {
                SearchModel *model = [[SearchModel alloc] initWihDict:dict];
                [weakSelf.dateSource addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark-UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SearchViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    SearchModel *model = _dateSource[indexPath.row];
    [cell config:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchModel*model = _dateSource[indexPath.row];
    NSLog(@"%@",model.myId);
    DetailViewController *ctrl = [[DetailViewController alloc] init];
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
