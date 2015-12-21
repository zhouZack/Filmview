//
//  DetailViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/14.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "DetailViewController.h"
#import "ActorDetailViewController.h"

@interface DetailViewController ()

@property (nonatomic ,strong)UIView       *upView;
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UILabel *separateLabel;//第一条分割线
@property (nonatomic ,strong)UILabel *separateLabel2;//第一条分割线
@property (nonatomic ,assign)BOOL Consequence;//判断是否被收藏
@property (nonatomic ,strong)UIButton *saveBtn;
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108)];
    _scrollView.contentSize = CGSizeMake(0, 2*UIScreenHeight);
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    [self reloadDescriptionData];
}
- (void)setNav
{
    [self addtitleWithName:self.moedel.nm];
    [self addUIbarButtonItemWithName:@"分享" left:NO frame:CGRectMake(0, 0, 40, 40) target:self action:@selector(shareBtn)];
    
}
- (void)createView{
    
    _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 250)];
    _upView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    [_scrollView addSubview:_upView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 120, 170)];
    NSString *img = [ToolUtil changeImageStringWith:self.dictDate[@"img"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [_upView addSubview:imageView];
    
    _saveBtn = [ToolUtil buttonWithSize:CGSizeMake(170, 35) title:@"收藏" selectTitle:@"已收藏" layer:YES target:self action:@selector(reserveBtn:)];
    _saveBtn.centerX = UIScreenWidth/2;
    _saveBtn.top = imageView.bottom+15;
    _Consequence = [[FilmCoreDateHelper share] searchDataWith:self.myId];
    if (self.Consequence == YES) {
        _saveBtn.selected =YES;
    }
    [_upView addSubview:_saveBtn];
    
    UILabel *commentLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:[NSString stringWithFormat:@"(%@人评分)",self.dictDate[@"snum"]] color:[UIColor whiteColor]];
    [commentLabel sizeToFit];
    commentLabel.left = imageView.right +20;
    commentLabel.top = 50;
    [_upView addSubview:commentLabel];
    
    NSMutableString *cat = [NSMutableString stringWithFormat:@"%@",self.dictDate[@"cat"]];
    [cat replaceOccurrencesOfString:@"," withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, cat.length)];
    UILabel *typeLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:cat color:[UIColor whiteColor]];
    [typeLabel sizeToFit];
    typeLabel.left = commentLabel.left;
    typeLabel.top = commentLabel.bottom+15;
    [_upView addSubview:typeLabel];
    
    UILabel *timeLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:[NSString stringWithFormat:@"片长:%@分钟",self.dictDate[@"dur"]] color:[UIColor whiteColor]];
    [timeLabel sizeToFit];
    timeLabel.left = commentLabel.left;
    timeLabel.top = typeLabel.bottom + 15;
    [_upView addSubview:timeLabel];
    
    UILabel *dayLabel = [ToolUtil labelwithFrame:CGRectZero font:14 text:[NSString stringWithFormat:@"%@大陆上映",self.dictDate[@"rt"]] color:[UIColor whiteColor]];
    [dayLabel sizeToFit];
    dayLabel.left = timeLabel.left;
    dayLabel.top = timeLabel.bottom +15;
    [_upView addSubview:dayLabel];
    
    [self setDescrptionData];
    
}
- (void)reserveBtn:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected ==YES) {
        [self saveDate:self.myId];
    }else
    {
        [self deleteDate:self.myId];
    }
    
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
- (void)shareBtn{
    
}
#pragma mark- 加载简介数据
- (void)reloadDescriptionData{
    
    __weak DetailViewController *weakSelf = self;
    [HttpRequestHelper detailControlWithContainWithId:self.myId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.movieDescription = responseObject[@"data"][@"movie"][@"dra"];
            weakSelf.descriptionImage = responseObject[@"data"][@"movie"][@"photos"];
            weakSelf.dictDate = responseObject[@"data"][@"movie"];
            [weakSelf createView];
        }
        
    } Failure:^(NSError *error) {
        
        NSLog(@"error = %@",error);
    }];
}
- (void)setDescrptionData
{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _upView.bottom+20, UIScreenWidth-10, 10)];
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
    
    UIView *descriptionImage = [[UIView alloc] initWithFrame:CGRectMake(10, descriptionLabel.bottom+10, UIScreenWidth-20, 100)];
    CGFloat imageWidth = (descriptionImage.width-5*5)/4;
    CGFloat imageHeight = descriptionImage.height-10;
    if (self.descriptionImage.count >=4) {
        for (int i=0; i<4; i++) {
            UIImageView *image = [[UIImageView alloc] init];
            image.size = CGSizeMake(imageWidth, imageHeight);
            image.top = 5;
            image.left = i*(5+imageWidth)+5;
            NSMutableString*mbString = [NSMutableString stringWithFormat:@"%@",_descriptionImage[i]];
            [mbString replaceOccurrencesOfString:@"w" withString:@"200" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 25)];
            [mbString replaceOccurrencesOfString:@"h" withString:@"280" options:NSCaseInsensitiveSearch range:NSMakeRange(5, 30)];
            [image sd_setImageWithURL:[NSURL URLWithString:mbString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            image.layer.cornerRadius = 10;
            image.clipsToBounds = YES;
            [descriptionImage addSubview:image];
        }
    }else if (self.descriptionImage.count >0 && self.descriptionImage.count<4){
        for (int i=0; i<self.descriptionImage.count; i++) {
            UIImageView *image = [[UIImageView alloc] init];
            image.size = CGSizeMake(imageWidth, imageHeight);
            image.top = 5;
            image.left = i*(5+imageWidth)+5;
            NSMutableString*mbString = [NSMutableString stringWithFormat:@"%@",_descriptionImage[i]];
            [mbString replaceOccurrencesOfString:@"w" withString:[NSString stringWithFormat:@"%d",(int)imageWidth] options:NSCaseInsensitiveSearch range:NSMakeRange(0, 25)];
            [mbString replaceOccurrencesOfString:@"h" withString:[NSString stringWithFormat:@"%d",(int)imageHeight] options:NSCaseInsensitiveSearch range:NSMakeRange(5, 30)];
            [image sd_setImageWithURL:[NSURL URLWithString:mbString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            image.layer.cornerRadius = 10;
            image.clipsToBounds = YES;
            [descriptionImage addSubview:image];
        }
    }else{
        descriptionImage.height = 0;
    }
    [self.scrollView addSubview:descriptionImage];
    
    _separateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, descriptionImage.bottom+5, UIScreenWidth, 20)];
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

            
            //
            for (NSDictionary *dict in directors) {
         
                if (dict[@"cnm"] !=nil&&dict[@"enm"] !=nil&&dict[@"avatar"] !=nil&&dict[@"id"]!=nil) {
                    NSMutableDictionary*mDict = [[NSMutableDictionary alloc] init];
                    [mDict setObject:dict[@"cnm"] forKey:@"cnm"];
                    [mDict setObject:dict[@"enm"] forKey:@"enm"];
                    [mDict setObject:dict[@"avatar"] forKey:@"avatar"];
                    [mDict setObject:dict[@"id"] forKey:@"id"];
                    [weakSelf.directorArray addObject:mDict];
//                    [weakSelf.actorAndDirectorArray addObject:mDict];
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
//                [weakSelf.actorAndDirectorArray addObject:mDict];
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
    [actorScrollView addSubview:aLabel];
    for (int i =0; i<self.actorArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.size = CGSizeMake(imageWidth, imageHeight);
        imageView.top = dLabel.bottom;
        imageView.left = i*(imageWidth+7)+aLabel.left;
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
    
    [self.scrollView addSubview:actorScrollView];
    _separateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, actorScrollView.bottom, UIScreenWidth, 20)];
    _separateLabel2.backgroundColor = RGBColor(239, 239, 239);
    [self.scrollView addSubview:_separateLabel2];
    self.scrollView.contentSize = CGSizeMake(0, _separateLabel2.bottom);
    [self reloadRankingData];
    
}
- (void)actorClick:(UIButton*)button
{
    NSString *actorId = [NSString stringWithFormat:@"%ld",button.tag-10];
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
