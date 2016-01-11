//
//  MovieViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MovieViewController.h"
#import "AppDelegate.h"
#import "MovieModel.h"
#import "PagedFlowView.h"
#import "FXBlurView.h"
#import "MovieCell.h"
#import "DetailViewController.h"

#import "WaitshowControl.h"
#import "StarView.h"
#import "SearchViewController.h"

@interface MovieViewController ()<UITableViewDelegate,UITableViewDataSource,PagedFlowViewDataSource,PagedFlowViewDelegate>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,strong)PagedFlowView  *pageFlowView;
@property (nonatomic ,strong)FXBlurView     *fxBlurView;
@property (nonatomic ,strong) UIImageView   *blurImageView;
@property (nonatomic ,strong)UIScrollView   *baseScrollview;


@property (nonatomic ,strong)UISegmentedControl *segmentC;

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
    [FilmCoreDateHelper share].coreDataName = @"FilmCoreDate";
    _segmentC = [[UISegmentedControl alloc] initWithItems:@[@"热映",@"待映"]];
    _segmentC.size = CGSizeMake(UIScreenWidth/3, 25);
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [_segmentC setTitleTextAttributes:dict forState:UIControlStateNormal];
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.selectedSegmentIndex = 0;
    [_segmentC addTarget:self action:@selector(changeTypePrice:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentC;
    [self addUIbarButtonItemWithImage:@"menu@2x" left:NO frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    [self addUIbarButtonItemWithImage:@"save@2x" left:YES frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(searchClcik)];
    

    
    
}
- (void)changeTypePrice:(id)info
{
    if (_segmentC.selectedSegmentIndex == 0) {
        _baseScrollview.contentOffset = CGPointMake(0, 0);
    }else{
        _baseScrollview.contentOffset = CGPointMake(UIScreenWidth, 0);
    }
}
- (void)searchClcik
{
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
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
    
    _baseScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-113)];
    _baseScrollview.scrollEnabled = NO;
    _baseScrollview.contentSize = CGSizeMake(2*UIScreenWidth, 0);
    _baseScrollview.pagingEnabled = YES;
    [self.view addSubview:_baseScrollview];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-113) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak MovieViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadDate];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    [_baseScrollview addSubview:_tableView];
    
    WaitshowControl *waitShow = [[WaitshowControl alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight-113)];
    waitShow.block = ^(NSString*string){
         DetailViewController *detal = [[DetailViewController alloc] init];
        detal.myId = string;
        [self.navigationController pushViewController:detal animated:YES];
    };
    
    [_baseScrollview addSubview:waitShow];

}
- (void)change{
    [_pageFlowView removeFromSuperview];
    _pageFlowView = nil;
    [self createTableView];
}

- (void)changeLeft
{
    [self changeLeftList];
    
}

#pragma mark-UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _dateSource.count+1;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return UIScreenHeight-113;
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
        _pageFlowView = [[PagedFlowView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-113)];
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
        [blurView addSubview:_blurImageView];
        
        _fxBlurView = [[FXBlurView alloc] initWithFrame:_blurImageView.frame];//玻璃效果
        _fxBlurView.dynamic = YES;
        _fxBlurView.blurRadius = 20;
        _fxBlurView.tintColor = [UIColor clearColor];
        [blurView addSubview:_fxBlurView];
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
    
    if (indexPath.row == 0) return;
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    detail.status = YES;
    MovieModel *model = _dateSource[indexPath.row-1];
    detail.myId = model.myId;
    detail.imageViewName = model.img;
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView{
    CGFloat width = UIScreenWidth*210/375;
    CGFloat heigth = UIScreenHeight*400/667;
    return CGSizeMake(width, heigth);
}
- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)[flowView viewWithTag:1000+index];
    _blurImageView.image = imageView.image; //imageView.image;
    
}
- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index {
    
    DetailViewController*detail = [[DetailViewController alloc] init];
    MovieModel *model = _dateSource[index];
    detail.myId = model.myId;
    detail.status = YES;
    detail.imageViewName = model.img;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark - PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView {
    return [self.dateSource count];
}
//返回给某列使用的View,这个View的大小由上面的方法设定
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    
    MovieModel *model = _dateSource[index];
    
    
    UIView *view = (UIView *)[flowView dequeueReusableCell];
    
    if (!view) {
        view = [[UIView alloc] init];
    }
    
    for (UIView *sub in view.subviews) {
        [sub removeFromSuperview];
    }
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 252)]; // 图片原分辨率是200*280
    imageView.top = 0;
    imageView.centerX = [self sizeForPageInFlowView:flowView].width/2;
//    imageView.center = CGPointMake([self sizeForPageInFlowView:flowView].width/2,[self sizeForPageInFlowView:flowView].height/2-20);
    imageView.tag = 1000 + index;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (index == 0) {
            _blurImageView.image = image;
        }
    }];
    
    [view addSubview:imageView];
    
    // 片名
    UILabel *movieTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self sizeForPageInFlowView:flowView].width, 20)];
    movieTitleLabel.top = imageView.bottom+15;
    movieTitleLabel.centerX = imageView.centerX;
    movieTitleLabel.textAlignment = NSTextAlignmentCenter;
    movieTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:model.nm attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0.53 blue:0 alpha:1]}];
    [view addSubview:movieTitleLabel];
    
    UILabel *englishName = [[UILabel alloc] initWithFrame:movieTitleLabel.bounds];
    englishName.top = movieTitleLabel.bottom+5;
    englishName.centerX = movieTitleLabel.centerX;
    englishName.textAlignment = NSTextAlignmentCenter;
    englishName.attributedText = [[NSAttributedString alloc] initWithString:@"while detail code" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.6 alpha:1]}];
    [view addSubview:englishName];
    
    UIImageView *quetaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.left , englishName.bottom, 10, 9)];
    quetaImageView.image = [UIImage imageNamed:@"v10_quot"];
    [view addSubview:quetaImageView];
    
    UILabel*scmLabel = [[UILabel alloc] init];//简介
    scmLabel.top =quetaImageView.top;
    scmLabel.left = quetaImageView.right;
    scmLabel.attributedText = [[NSAttributedString alloc] initWithString:model.scm attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0.53 blue:0 alpha:1]}];
    [scmLabel sizeToFit];
    [view addSubview:scmLabel];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@月%@日上映/%@分钟", [model.rt substringWithRange:NSMakeRange(5, 2)], [model.rt substringWithRange:NSMakeRange(8, 2)], model.dur];
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.top = scmLabel.bottom;
    timeLabel.left = quetaImageView.left;
    timeLabel.attributedText = [[NSAttributedString alloc] initWithString:dateStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.6 alpha:1]}];
    [timeLabel sizeToFit];
    [view addSubview:timeLabel];
    
    UILabel *actor = [[UILabel alloc] init];
    actor.top = timeLabel.bottom;
    actor.left = timeLabel.left;
    [view addSubview:actor];
    if (model.star) {
        NSMutableString *actorStr = [NSMutableString stringWithString:model.star];
        [actorStr replaceOccurrencesOfString:@"," withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, model.star.length)];
        actor.attributedText = [[NSAttributedString alloc] initWithString:actorStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.6 alpha:1]}];
        [actor sizeToFit];
        
    }
    
    
    /*
     
     @property (nonatomic ,copy)NSString   *nm;//名字
     @property (nonatomic ,assign)double    mk;//评分
     @property (nonatomic ,copy)NSString   *scm;//简介
     @property (nonatomic ,copy)NSString   *rt;//上映时间
     @property (nonatomic ,copy)NSString   *dur;//影片时长
     @property (nonatomic ,copy)NSString   *star;//明星
     @property (nonatomic ,copy)NSString   *img;//图片
     //@property (nonatomic ,strong,setter =setId:)NSNumber *myId;
     @property (nonatomic ,copy)NSString   *myId;
     @property (nonatomic ,copy)NSString   *ver;//3D／2D／IMAX
     
     
     @property (nonatomic ,copy)NSString   *snum;//评论人数

     */
    
    StarView *starView = [[StarView alloc] initWithFrame:CGRectMake(actor.left, actor.bottom+5, 90, 15)];
    [starView setStarView:model.mk];
//    starView.backgroundColor = [UIColor cyanColor];
    [view addSubview:starView];
    
    UILabel *integerLabel = [[UILabel alloc] init];//评分整数部分
    integerLabel.top = actor.bottom;
    integerLabel.left = starView.right;
    integerLabel.attributedText = [[NSAttributedString alloc] initWithString:[[NSString stringWithFormat:@"%f",model.mk] substringToIndex:1] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:24],NSForegroundColorAttributeName:[UIColor colorWithRed:99/255.0 green:154/255.0 blue:30/255.0 alpha:1.000]}];
    [integerLabel sizeToFit];
    [view addSubview:integerLabel];
    
    UILabel *decimalLabel = [[UILabel alloc] init];//评分小数部分
    decimalLabel.top = integerLabel.top+5;
    decimalLabel.left = integerLabel.right;
    decimalLabel.attributedText = [[NSAttributedString alloc] initWithString:[[[NSString stringWithFormat:@"%f",model.mk] substringFromIndex:1] substringToIndex:2]  attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:99/255.0 green:154/255.0 blue:30/255.0 alpha:1.000]}];
    [decimalLabel sizeToFit];
    [view addSubview:decimalLabel];
    
//    view.backgroundColor  = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
    
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
