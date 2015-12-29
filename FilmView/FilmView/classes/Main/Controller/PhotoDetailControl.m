//
//  PhotoDetailControl.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/25.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "PhotoDetailControl.h"
#import "PhotoCell.h"
#import "PhotoDetailCell.h"

@interface PhotoDetailControl ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation PhotoDetailControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];

    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [ToolUtil barButtonWithImage:@"icon_clear@2x" frame:CGRectMake(0, 0, 40, 40) left:YES target:self action:@selector(BackBtnClick)];
    self.navigationController.navigationBarHidden =YES;

    [self createtableView];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"icon_clear@2x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)BackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.tabBarController.tabBar.hidden =YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:RGBColor(42, 162, 239)];
    self.navigationController.navigationBarHidden = NO;
     self.tabBarController.tabBar.hidden =NO;
}
- (void)createtableView
{
    NSLog(@"%ld",self.dateSource.count);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenHeight-108, UIScreenWidth) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.4];
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.pagingEnabled = YES;
    _tableView.showsHorizontalScrollIndicator =  _tableView.showsVerticalScrollIndicator =  NO;
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tableView.center = CGPointMake(UIScreenWidth / 2, (UIScreenHeight) / 2);
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:self.photoNumber inSection:0];
    
    [[self tableView] scrollToRowAtIndexPath:scrollIndexPath
                            atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.view addSubview: _tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.size.width;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellId = @"cellId";
    PhotoDetailCell*cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PhotoDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.width = self.tableView.width;
    cell.height = self.tableView.height;
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    [cell config:self.dateSource[indexPath.row]];
    
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
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
