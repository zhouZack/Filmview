//
//  DetailViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/14.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "DetailViewController.h"
#import "ActorDetailViewController.h"
#import "PhotoViewControl.h"
#import "MainViewController.h"
#import "StarView.h"
#import "PhotoCell.h"
#import "PhotoDetailControl.h"
#import "MyLayout.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"
@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyLayoutDelegate>

@property (nonatomic ,strong)UIView       *upView;
@property (nonatomic ,strong)UIView    *bgImageview;//电影图片
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UILabel *separateLabel;//第一条分割线
@property (nonatomic ,strong)UILabel *separateLabel2;//第一条分割线
@property (nonatomic ,assign)BOOL Consequence;//判断是否被收藏
@property (nonatomic ,assign)BOOL showScrollView;//判断是否显示ScrollView
@property (nonatomic ,strong)UIButton *saveBtn;
@property (nonatomic ,strong)MPMoviePlayerViewController *moviePlayer;
@property (nonatomic ,strong)UIImageView *downImageView;


//数据
/**
 简介
 */
@property (nonatomic ,strong)NSDictionary *dictDate;
@property (nonatomic ,strong)NSString     *movieDescription;//电影简介
@property (nonatomic ,strong)NSArray      *descriptionImage;//保存电影简介图片
/**
 演员和导演
 */
@property (nonatomic ,strong)NSMutableArray *actorAndDirectorArray;//保存演员和导演图片中英文名字
@property (nonatomic ,strong)NSMutableArray *actorArray;
@property (nonatomic ,strong)NSMutableArray *directorArray;
/**
 collectionView
 */
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)NSMutableArray *dateSourceCollection;
@property (nonatomic ,strong)NSMutableArray *heightArr;//保存cell高度的数组

@end

@implementation DetailViewController

- (NSArray *)descriptionImage{
    if (_descriptionImage == nil) {
        _descriptionImage = [[NSArray alloc] init];
    }
    return _descriptionImage;
}
- (NSMutableArray *)actorArray
{
    if (_actorArray ==nil) {
        _actorArray = [[NSMutableArray alloc] init];
    }
    return _actorArray;
}
- (NSMutableArray*)directorArray
{
    if (_directorArray == nil) {
        _directorArray = [[NSMutableArray alloc] init];
    }
    return _directorArray;
}
- (NSMutableArray *)actorAndDirectorArray
{
    if (_actorAndDirectorArray == nil) {
        _actorAndDirectorArray = [[NSMutableArray alloc] init];
    }
    return _actorAndDirectorArray;
}
- (NSMutableArray*)dateSourceCollection
{
    if (_dateSourceCollection ==nil) {
        _dateSourceCollection = [[NSMutableArray alloc] init];
    }
    return _dateSourceCollection;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MainViewController *tab = (MainViewController*)self.tabBarController;
    [tab hideTabBar];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainViewController *tab = (MainViewController*)self.tabBarController;
    [tab showTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    [self setNav];
    [self setDownView];
    [self setUpScrollView];
    
}
- (void)setNav
{
    self.navigationItem.hidesBackButton = YES;
    [self addUIbarButtonItemWithImage:@"back@2x" left:YES frame:CGRectMake(0, 0, 15, 25) target:self action:@selector(backClick:)];
    
    [self addUIbarButtonItemWithName:@"收藏" left:NO frame:CGRectMake(0, 0, 60, 40) target:self action:@selector(reserveBtn:)];
    _Consequence = [[FilmCoreDateHelper share] searchDataWith:self.myId];
    if (self.Consequence == YES) {
        UIButton*btn = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
        
        btn.selected =YES;
    }
    
}

- (void)setDownView
{
    _downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 280)];

    _downImageView.userInteractionEnabled = YES;
    UIButton *movieBtn = [[UIButton alloc] init];
    movieBtn.size = CGSizeMake(40, 40);
    movieBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    [movieBtn setBackgroundImage:[UIImage imageNamed:@"play@2x"] forState:UIControlStateNormal];
    movieBtn.center = _downImageView.center;
    movieBtn.layer.cornerRadius = 5;
    [movieBtn addTarget: self action:@selector(movieBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_downImageView addSubview:movieBtn];
    [self.view addSubview:_downImageView];
    [self createCollectionView];

}
- (void)setUpScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(0, 2*UIScreenHeight);
    _scrollView.bounces = NO;
    
    UIView *uuuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 280)];
    uuuView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:uuuView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRespond:)];
    tapGesture.numberOfTouchesRequired = 1;
    [uuuView addGestureRecognizer:tapGesture];
    
    
    [self.view addSubview:_scrollView];
    [self reloadDescriptionData];

}
- (void)movieBtnClick
{
    if (self.dictDate[@"videourl"]!=nil) {
        
        //路径
        NSURL *url = [NSURL URLWithString:self.dictDate[@"videourl"]];
        
        if (_moviePlayer) {
            [_moviePlayer.moviePlayer stop];
            _moviePlayer = nil;
        }
        
        _moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        
        //播放
        [_moviePlayer.moviePlayer prepareToPlay];
        [_moviePlayer.moviePlayer play];
        
        //显示
        [self presentViewController:_moviePlayer animated:YES completion:nil];

        
    }
}

- (void)createCollectionView
{
    MyLayout *myLayout = [[MyLayout alloc] initWithSectionInsets:UIEdgeInsetsMake(5, 5, 5, 5) itemSpace:5 lineSpace:5];
    
    myLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 280, UIScreenWidth, UIScreenHeight-344) collectionViewLayout:myLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview: _collectionView];
    [self reloadCollectionViewData];
}
- (void)reloadCollectionViewData
{
    __weak __typeof(self)weakSelf = self;
    [HttpRequestHelper photoControlWithMyId:self.myId success:^(id responseObject){
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *arrayImg = responseObject[@"data"];
            if (arrayImg.count != 0) {
                for (NSDictionary *dict in arrayImg) {
                    [weakSelf.dateSourceCollection addObject:dict];
                }
            }
            [weakSelf addtitleWithName:[NSString stringWithFormat:@"%ld张剧照",arrayImg.count]];
            [weakSelf.collectionView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
}
#pragma mark-UICollcetionView代理协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dateSourceCollection.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSDictionary*dict = _dateSourceCollection[indexPath.item];
    [cell config:dict];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailControl *detail = [[PhotoDetailControl alloc] init];
    detail.dateSource = self.dateSourceCollection;
    detail.photoNumber = indexPath.item;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - MyLayout代理
-(int)columnsInCollectionView
{
    return 3;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    //  DataModel *model = _dataArray[indexPath.item];
    return 150+arc4random()%40;
}

#pragma mark-滑动手势调用方法
- (void)tapGestureRespond:(UIGestureRecognizer*)ges
{
    self.showScrollView = !self.showScrollView;
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = _scrollView.frame;
        frame.origin.y = UIScreenHeight;
        _scrollView.frame = frame;
    }];
}
#pragma mark-返回界面调用方法
- (void)backClick:(UIButton*)button
{
    if (self.showScrollView == YES) {
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = _scrollView.frame;
            frame.origin.y = 0;
            _scrollView.frame = frame;
        }];
        self.showScrollView = NO;
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark- 加载简介数据
- (void)reloadDescriptionData{
    __weak DetailViewController *weakSelf = self;
    [HttpRequestHelper detailControlWithContainWithId:self.myId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.movieDescription = responseObject[@"data"][@"movie"][@"dra"];
            weakSelf.descriptionImage = responseObject[@"data"][@"movie"][@"photos"];
            weakSelf.dictDate = responseObject[@"data"][@"movie"];
            [weakSelf setDescriptionView];
        }
    } Failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)setDescriptionView{
    if (self.dictDate[@"videourl"]==nil) {
        for (UIView*view in _downImageView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton*btn = (UIButton*)view;
                btn.hidden = YES;
            }
        }
    }
    
    [_downImageView sd_setImageWithURL:[NSURL URLWithString:[ToolUtil changeDeleteImageStringWith:self.dictDate[@"img"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, UIScreenWidth, UIScreenHeight*2)];
    _upView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_upView];
    
    _bgImageview = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 126, 176)];
    _bgImageview.backgroundColor = [UIColor whiteColor];
    _bgImageview.layer.cornerRadius = 3;
    _bgImageview.centerY = _upView.top;
    [_scrollView addSubview:_bgImageview];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 120, 170)];
    NSString *img = [ToolUtil changeImageStringWith:self.dictDate[@"img"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [_bgImageview addSubview:imageView];
    UIImageView *ddImage = [[UIImageView alloc] initWithFrame:CGRectMake(_bgImageview.right+30, _upView.top-30, 40, 20)];
    ddImage.image = [[UIImage imageNamed:@"downImage@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_scrollView addSubview:ddImage];
    
    if (self.status == YES) {
        StarView *start = [[StarView alloc] initWithFrame:CGRectMake(_bgImageview.right+10, _bgImageview.top+5, 90, 15)];
        [_scrollView addSubview:start];
        
    }
    
    UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(_bgImageview.right+10, _bgImageview.top+30, 150, 30) font:23 text:self.dictDate[@"nm"] color:[UIColor whiteColor]];
    nameLabel.font = [UIFont boldSystemFontOfSize:22];
    [_scrollView addSubview:nameLabel];
    
    NSMutableString *cat = [NSMutableString stringWithFormat:@"%@",self.dictDate[@"cat"]];
    [cat replaceOccurrencesOfString:@"," withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, cat.length)];
    UILabel *typeLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:cat color:[UIColor colorWithWhite:0.2 alpha:1]];
    [typeLabel sizeToFit];
    typeLabel.left = nameLabel.left;
    typeLabel.top = 10;
    [_upView addSubview:typeLabel];
    
    
    UILabel *timeLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:[NSString stringWithFormat:@"片长:%@分钟",self.dictDate[@"dur"]] color:[UIColor colorWithWhite:0.2 alpha:1]];
    [timeLabel sizeToFit];
    timeLabel.left = typeLabel.left;
    timeLabel.top = typeLabel.bottom + 7;
    [_upView addSubview:timeLabel];
    
    UILabel *dayLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:[NSString stringWithFormat:@"%@大陆上映",self.dictDate[@"rt"]] color:[UIColor colorWithWhite:0.2 alpha:1]];
    [dayLabel sizeToFit];
    dayLabel.left = timeLabel.left;
    dayLabel.top = timeLabel.bottom +7;
    [_upView addSubview:dayLabel];
    
    [self setDescrptionData];
    
}
- (void)setDescrptionData
{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _bgImageview.bottom+20, UIScreenWidth-10, 10)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;//设置行的距离
    //!!!: 首行缩进2个中文字符
    style.firstLineHeadIndent = 30;
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1], NSParagraphStyleAttributeName:style};
    
    CGRect descritpionFrame = [self.movieDescription boundingRectWithSize:CGSizeMake(descriptionLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    descriptionLabel.attributedText = [[NSAttributedString alloc] initWithString:self.movieDescription attributes:dict];
    descriptionLabel.numberOfLines = 0;
    
    CGRect frame = descriptionLabel.frame;
    frame.size.height = descritpionFrame.size.height;
    descriptionLabel.frame =frame;
    [self.scrollView addSubview:descriptionLabel];
    
    _separateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, descriptionLabel.bottom+5, UIScreenWidth, 20)];
    _separateLabel.backgroundColor = RGBColor(239, 239, 239);
    [self.scrollView addSubview:_separateLabel];
    self.scrollView.contentSize = CGSizeMake(0, _separateLabel.bottom);
    [self reloadActorData];
    
}

#pragma mark- 加载演员导演数据
- (void)reloadActorData{
    __weak DetailViewController *weakSelf = self;
    [HttpRequestHelper detailControlWithactorWithId:self.myId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *directors = responseObject[@"data"][@"directors"];
            NSArray *actors = responseObject[@"data"][@"actors"];
            for (NSDictionary *dict in directors) {
         
                if (dict[@"cnm"] !=nil&&dict[@"enm"] !=nil&&dict[@"avatar"] !=nil&&dict[@"id"]!=nil) {
                    NSMutableDictionary*mDict = [[NSMutableDictionary alloc] init];
                    [mDict setObject:dict[@"cnm"] forKey:@"cnm"];
                    [mDict setObject:dict[@"enm"] forKey:@"enm"];
                    [mDict setObject:dict[@"avatar"] forKey:@"avatar"];
                    [mDict setObject:dict[@"id"] forKey:@"id"];
                    [weakSelf.directorArray addObject:mDict];
                }
               
            }
            for (NSDictionary *dict in actors) {
                if (dict[@"cnm"] !=nil&&dict[@"roles"] !=nil&&dict[@"avatar"] !=nil) {
                NSMutableDictionary*mDict = [[NSMutableDictionary alloc] init];
                [mDict setObject:dict[@"cnm"] forKey:@"cnm"];
                [mDict setObject:dict[@"roles"] forKey:@"roles"];
                [mDict setObject:dict[@"avatar"] forKey:@"avatar"];
                [mDict setObject:dict[@"id"] forKey:@"id"];
                [weakSelf.actorArray addObject:mDict];
                }
            }
            [weakSelf setActorData];
        }
    } Failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)setActorData
{
    
    UIScrollView *actorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, _separateLabel.bottom+10, UIScreenWidth-20, 210)];
    actorScrollView.bounces = NO;
    CGFloat imageWidth = (actorScrollView.width-3*7)/4;
    CGFloat imageHeight = actorScrollView.height-90;
    UILabel *dLabel = [ToolUtil labelwithFrame:CGRectMake(0, 5, 60, 30) font:15 text:@"导演" color:[UIColor blackColor]];
    [actorScrollView addSubview:dLabel];
    //加载导演数据
    for (int i=0 ; i<self.directorArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.size = CGSizeMake(imageWidth, imageHeight);
        imageView.top = dLabel.bottom;
        imageView.left = i*(imageWidth+7);
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 8;
        NSString *imString = [ToolUtil changeImageStringWith:self.directorArray[i][@"avatar"]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [actorScrollView addSubview:imageView];
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.left, imageView.bottom+5, imageView.width, 20) font:11 text:self.directorArray[i][@"cnm"] color:[UIColor blackColor]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [actorScrollView addSubview:nameLabel];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(imageView.left, imageView.top, imageView.width, actorScrollView.height-45)];
        NSNumber *numberId = self.directorArray[i][@"id"];
        NSInteger integerId = [numberId integerValue];
        btn.tag = 10+integerId;
        [btn addTarget:self action:@selector(actorClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [actorScrollView addSubview:btn];
    }
    //演员部分数据
    UILabel *aLabel = [ToolUtil labelwithFrame:CGRectMake((imageWidth+7)*self.directorArray.count, 5, 60, 30) font:15 text:@"演员" color:[UIColor blackColor]];
    if (self.directorArray.count == 0) {
        aLabel.width = 0;
    }
    [actorScrollView addSubview:aLabel];
    for (int i =0; i<self.actorArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.size = CGSizeMake(imageWidth, imageHeight);
        imageView.top = dLabel.bottom;
        imageView.left = i*(imageWidth+7)+aLabel.left;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 8;
        NSString *imString = [ToolUtil changeImageStringWith:self.actorArray[i][@"avatar"]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [actorScrollView addSubview:imageView];
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.left, imageView.bottom+5, imageView.width, 20) font:11 text:self.actorArray[i][@"cnm"] color:[UIColor blackColor]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [actorScrollView addSubview:nameLabel];
        if (self.actorArray[i][@"roles"]!=nil) {
            UILabel *rolesLabel = [ToolUtil labelwithFrame:CGRectMake(imageView.left, nameLabel.bottom+3, imageView.width, 20) font:11 text:[NSString stringWithFormat:@"饰 %@",self.actorArray[i][@"roles"]] color:[UIColor grayColor]];
            rolesLabel.textAlignment = NSTextAlignmentCenter;
            [actorScrollView addSubview:rolesLabel];
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(imageView.left, imageView.top, imageView.width, actorScrollView.height-45)];
        NSNumber *numberId = self.actorArray[i][@"id"];
        NSInteger integerId = [numberId integerValue];
        btn.tag = 10+integerId;
        [btn addTarget:self action:@selector(actorClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [actorScrollView addSubview:btn];


    }
    NSInteger number = self.directorArray.count +self.actorArray.count;
    actorScrollView.contentSize = CGSizeMake(number*(imageWidth+7)-7, 0);
    if (self.actorArray.count==0&&self.directorArray.count ==0) {
        actorScrollView.height = 0;
    }
    [self.scrollView addSubview:actorScrollView];
    _separateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, actorScrollView.bottom, UIScreenWidth, 20)];
    _separateLabel2.backgroundColor = RGBColor(239, 239, 239);
    [self.scrollView addSubview:_separateLabel2];
    self.scrollView.contentSize = CGSizeMake(0, _separateLabel2.bottom);

    [self reloadRankingData];
    
}
- (void)actorClick:(UIButton*)button
{
    NSString *actorId = [NSString stringWithFormat:@"%d",button.tag-10];
    ActorDetailViewController *actor = [[ActorDetailViewController alloc] init];
    actor.myId = actorId;
    [self.navigationController pushViewController:actor animated:YES];
    
}
#pragma mark- 加载排数据
- (void)reloadRankingData
{
    __weak DetailViewController *weakSelf = self;
    [HttpRequestHelper detailControlWithBoxOfficeWithId:self.myId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           
            [weakSelf setRankingData:responseObject];
        }
    } Failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)setRankingData:(NSDictionary *)dict
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _separateLabel2.bottom, UIScreenWidth, 100)];
    [self.scrollView addSubview:view];
    if (dict[@"lastDayRank"]!=nil &&dict[@"firstWeekBox"]!=nil && dict[@"sumOverSeaBox"]!=nil) {
        NSArray *arraytile = @[@"昨日票房排名",@"首周票房(万)",@"累计票房(万)"];
        NSNumberFormatter *numf = [[NSNumberFormatter alloc] init];
        [numf stringFromNumber:dict[@"lastDayRank"]];
        NSArray *arraynum = @[[numf stringFromNumber:dict[@"lastDayRank"]],[numf stringFromNumber:dict[@"firstWeekBox"]],[numf stringFromNumber:dict[@"sumOverSeaBox"]]];
        
        for (int i =0; i<3; i++) {
            UILabel *num = [ToolUtil labelwithFrame:CGRectMake(i*UIScreenWidth/3, 20, UIScreenWidth/3, 40) font:25 text:arraynum[i] color:[UIColor redColor]];
            num.textAlignment = NSTextAlignmentCenter;
            if ([arraynum[i] isEqualToString:@"0"]) {
                num.text = @"暂无数据";
                num.font = [UIFont systemFontOfSize:20];
                num.textColor = [UIColor grayColor];
            }
            [view addSubview:num];
            UILabel *title = [ToolUtil labelwithFrame:CGRectMake(i*UIScreenWidth/3, num.bottom, UIScreenWidth/3, 40) font:14 text:arraytile[i] color:[UIColor grayColor]];
            title.textAlignment = NSTextAlignmentCenter;
            [view addSubview:title];
        }
    }else{
        view.height = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(0, view.bottom);

    _upView.height = self.scrollView.contentSize.height-10;
    
    
}
#pragma mark-保存数据
- (void)saveDate:(NSString *)strId
{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.dictDate[@"nm"] forKey:@"name"];
        NSString*img = [ToolUtil changeImageStringWith:self.dictDate[@"img"]];
        [dict setObject:img forKey:@"image"];
        [dict setObject:strId forKey:@"myId"];
        [[FilmCoreDateHelper share] insertCoreData:dict];
    
}
- (void)deleteDate:(NSString *)strId
{
    [[FilmCoreDateHelper share] deleteDataWith:strId];
}
- (void)reserveBtn:(UIButton*)button{
    
    button.selected = !button.selected;
    if (button.selected ==YES) {
        [self saveDate:self.myId];
    }else
    {
        [self deleteDate:self.myId];
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
