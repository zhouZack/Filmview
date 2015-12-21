//
//  ActorDetailViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ActorDetailViewController.h"
#import "ActorDetailCell.h"
#import "ActorDetialModel.h"
#import "DetailViewController.h"
@interface ActorDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSDictionary   *abstractDict;
@property (nonatomic ,strong)NSMutableArray *workDateSource;
@property (nonatomic ,copy)NSString *total;//影片总数
@property (nonatomic ,strong)UIView *headView;



@end

@implementation ActorDetailViewController
- (NSMutableArray *)workDateSource
{
    if (_workDateSource == nil) {
        _workDateSource = [[NSMutableArray alloc] init];
    }
    return _workDateSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.myId);
    [self setNav];
    [self createTableview];
    [self reloadAbstractData];
}
- (void)setNav
{
    [self addtitleWithName:@"影人详情"];
}
- (void)createTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (void)createHeadView
{
    _headView = [[UIView alloc] init];
    _headView.size = CGSizeMake(UIScreenWidth, 200);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 150)];
    NSString *img = [ToolUtil changeImageStringWith:self.abstractDict[@"avatar"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [_headView addSubview:imageView];
    CGFloat top = imageView.top;
    //中文名
    if (self.abstractDict[@"cnm"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"中文名:%@",self.abstractDict[@"cnm"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    //英文名
    if (self.abstractDict[@"enm"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"英文名:%@",self.abstractDict[@"enm"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    //性别
    if (self.abstractDict[@"sexy"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"性别:%@",self.abstractDict[@"sexy"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    //生日
    if (self.abstractDict[@"birthday"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"生日:%@",self.abstractDict[@"birthday"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    //星座
    if (self.abstractDict[@"constellation"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"星座:%@",self.abstractDict[@"constellation"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    //出生地
    if (self.abstractDict[@"birthplace"]!=nil) {
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.right+10, top, 150, 20) font:14 text:[NSString stringWithFormat:@"出生地:%@",self.abstractDict[@"birthplace"]] color:[UIColor blackColor]];
        [_headView addSubview:nameLabel];
        top = nameLabel.bottom+5;
    }
    top = imageView.bottom+5;
    
    //人物简介
    if (self.abstractDict[@"desc"]!=nil) {
        UILabel *peopleAbstract = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom+5, _headView.width-20, 10)];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 10;
        style.firstLineHeadIndent = 30;
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:style};
        NSString*str = self.abstractDict[@"desc"];
        
        CGRect abstractFrame = [str boundingRectWithSize:CGSizeMake(peopleAbstract.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        peopleAbstract.attributedText = [[NSAttributedString alloc] initWithString:self.abstractDict[@"desc"] attributes:dict];
        peopleAbstract.numberOfLines = 0;
        CGRect frame = peopleAbstract.frame;
        frame.size.height = abstractFrame.size.height;
        peopleAbstract.frame =frame;
        [_headView addSubview:peopleAbstract];
        top = peopleAbstract.bottom+5;
    }
    //图片
    NSArray *imageArray = self.abstractDict[@"photos"];
    if (imageArray.count!=0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(imageView.left, top, _headView.width-20, 80)];
        [_headView addSubview:view];
        top = view.bottom;
        CGFloat width = (view.width-15)/4;
        for (int i =0; i<imageArray.count; i++) {
            UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width+5), 0, width, 80)];
            photo.layer.cornerRadius = 5;
            photo.clipsToBounds = YES;
            NSString*img = [ToolUtil changeImageStringWith:imageArray[i]];
            [photo sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [view addSubview:photo];
            
        }
        
    }
   
        _headView.height = top;
   
    [self reloadActorWorkData];
}
#pragma mark-下载数据
- (void)reloadAbstractData
{    __weak ActorDetailViewController *weakSelf = self;
    [HttpRequestHelper actorDetailControlWithAbstractId:self.myId success:^(id responseObject) {
        weakSelf.abstractDict = responseObject[@"data"];
        [weakSelf createHeadView];
    } Failure:^(NSError *error) {
         NSLog(@"error= %@",error);
    }];
}
- (void)reloadActorWorkData
{
    __weak ActorDetailViewController *weakSelf = self;
    [HttpRequestHelper actorDetailControlWithWorkId:self.myId success:^(id responseObject) {
        weakSelf.total = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"total"]];
        NSArray *array = responseObject[@"data"][@"movies"];
        for (NSDictionary *dict in array) {
            ActorDetialModel *model = [[ActorDetialModel alloc] initWith:dict];
            [weakSelf.workDateSource addObject:model];
            
        }
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"error= %@",error);
    }];
    
}
#pragma mark-UITableView代理协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else
    {
        return self.workDateSource.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 30;
    }
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else
    {
        return [NSString stringWithFormat:@"作品介绍(%@)",self.total];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _headView.height;
    }
    else
    {
        return 120;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *cellId = @"cellIdOne";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [cell.contentView addSubview:_headView];
        return cell;
    }else{
        static NSString *cellId = @"cellIdTwo";
        ActorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell ==nil) {
            cell = [[ActorDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.size = CGSizeMake(UIScreenWidth, 120);
        ActorDetialModel *model = _workDateSource[indexPath.row];
        
        [cell configCellWith:model];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        DetailViewController*detail = [[DetailViewController alloc] init];
        ActorDetialModel*model = _workDateSource[indexPath.row];
        detail.myId = model.myId;
        [self.navigationController pushViewController:detail animated:YES];
    }
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
