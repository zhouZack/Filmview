//
//  MovieViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MovieViewController.h"
#import "AppDelegate.h"
#import "WaitShowViewController.h"
#import "MovieModel.h"
#import "PagedFlowView.h"
#import "FXBlurView.h"
#import "MovieCell.h"
#import "DetailViewController.h"

@interface MovieViewController ()<UITableViewDelegate,UITableViewDataSource,PagedFlowViewDataSource,PagedFlowViewDelegate>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,strong)PagedFlowView  *pageFlowView;
@property (nonatomic ,strong)FXBlurView     *fxBlurView;
@property (nonatomic, strong) UIImageView   *blurImageView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self setNav];
    [self createTableView];
    
}
-(NSMutableArray *)dateSource{
    if (_dateSource ==nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}

- (void)setNav{
    [self addtitleWithName:@"热映"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:YES frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    [self addUIbarButtonItemWithName:@"待映" left:NO frame:CGRectMake(0, 0, 40, 40) target:self action:@selector(comeWaitShow)];
    
    
}

- (void)reloadDate{
    
    [self.dateSource removeAllObjects];
    
    [HttpRequestHelper moveControlRequestSuccess:^(id responseObject) {
        NSArray *array = responseObject[@"data"][@"hot"][0][@"movies"];
        for (NSDictionary *dict in array) {
            MovieModel *model = [[MovieModel alloc] initWithDict:dict];
            [self.dateSource addObject:model];
           
            
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
       
    } Failure:^(NSError *error) {
         NSLog(@"Error = %@",error);
        [_tableView.mj_header endRefreshing];
 
    }];
    
    
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak MovieViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadDate];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
   
}
- (void)change{
    [_pageFlowView removeFromSuperview];
    _pageFlowView = nil;
    [self createTableView];
}
- (void)comeWaitShow{
    
    [self.navigationController pushViewController:[[WaitShowViewController alloc] init] animated:YES];
}
- (void)changeLeft
{
    [self changeLeftList];
    [_tableView reloadData];
}

#pragma mark-UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 300;
    }else{
        return 118;
    }
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        static NSString *cellId = @"cellId";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [_pageFlowView removeFromSuperview];
        _pageFlowView = nil;
        _pageFlowView = [[PagedFlowView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 300)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.9;//左右视图的透明度
        _pageFlowView.minimumPageScale = 0.8;//左右视图的比例
        [cell.contentView addSubview:_pageFlowView];
        
        UIView *blurView = [[UIView alloc] initWithFrame:_pageFlowView.frame];
        
        [_pageFlowView addSubview:blurView];
        
        _blurImageView = [[UIImageView alloc] initWithFrame:_pageFlowView.frame];
        _blurImageView.clipsToBounds = YES;
        _blurImageView.contentMode = UIViewContentModeScaleAspectFill;
//        [blurView addSubview:_blurImageView];
        
        _fxBlurView = [[FXBlurView alloc] initWithFrame:_blurImageView.frame];//玻璃效果
        _fxBlurView.dynamic = YES;
        _fxBlurView.blurRadius = 20;
        _fxBlurView.tintColor = [UIColor clearColor];
//        [blurView addSubview:_fxBlurView];
        [_pageFlowView sendSubviewToBack:blurView];//设置blurView为最底层的view；
        
        return cell;
    }else
    {
        static NSString *cellId = @"MovieCellId";
        MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        MovieModel *model = _dateSource[indexPath.row-1];
        [cell configCell:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    detail.moedel = _dateSource[indexPath.row-1];
    
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView{
    return CGSizeMake(210, 300);
}
- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)[flowView viewWithTag:1000+index];
    _blurImageView.image = imageView.image; //imageView.image;
    
}
- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index {
    
    

}
#pragma mark - PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView {
    return [self.dateSource count];
}
//返回给某列使用的View,这个View的大小由上面的方法设定
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    
    UIView *view = (UIView *)[flowView dequeueReusableCell];
    
    if (!view) {
        view = [[UIView alloc] init];
    }
    
    for (UIView *sub in view.subviews) {
        [sub removeFromSuperview];
    }
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 252)]; // 图片原分辨率是200*280
    imageView.center = CGPointMake([self sizeForPageInFlowView:flowView].width/2, [self sizeForPageInFlowView:flowView].height/2-20);
    imageView.tag = 1000 + index;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.dateSource[index] img]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (index == 0) {
            _blurImageView.image = image;
        }
    }];
    
    [view addSubview:imageView];
    
    // 片名
    UILabel *movieTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self sizeForPageInFlowView:flowView].width, 20)];
    
    movieTitleLabel.center = CGPointMake(100, [self sizeForPageInFlowView:flowView].height - movieTitleLabel.bounds.size.height);
    movieTitleLabel.textAlignment = NSTextAlignmentCenter;
    movieTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:[self.dateSource[index] nm] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0.53 blue:0 alpha:1]}];
    [view addSubview:movieTitleLabel];
    
    return view;
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
