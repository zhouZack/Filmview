//
//  CollectViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectItem.h"
#import "DetailViewController.h"
@interface CollectViewController ()
@property (nonatomic ,assign)NSInteger num;
@property (nonatomic ,strong)NSArray *savedDateArray;

@property (nonatomic ,strong)UIScrollView *scrollView;
@end

@implementation CollectViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    self.savedDateArray = [[FilmCoreDateHelper share] selectData:0 andOffset:0];
    [self addView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addtitleWithName:@"我的收藏"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108)];
    self.scrollView.backgroundColor = RGBColor(239, 239, 239);
    self.scrollView.contentSize = CGSizeMake(0, UIScreenHeight-108);
    [self.view addSubview:self.scrollView];
    
}

- (void)addView
{

    
    CGFloat width = (UIScreenWidth-24)/3;
    CGFloat heigth = width*1.5;
    for (int i=0; i<self.savedDateArray.count; i++) {
        CollectItem *item = _savedDateArray[i];
        NSInteger section = i/3;
        NSInteger row = i%3;
        UIView *view = [[UIView alloc] init];
        view.left = 5+row * (width+7);
        view.top = 5+section * (heigth+5);
        view.size = CGSizeMake(width, heigth);
        [self.scrollView addSubview:view];
        UILabel *nameLabel = [ToolUtil labelwithFrame:CGRectMake(0, view.height-20, view.width, 20) font:17 text:item.name color:[UIColor blackColor]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:nameLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height-25)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.image]];
        [view addSubview:imageView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    NSInteger sectionNum = self.savedDateArray.count/3;
    CGFloat accountHeight = 5+heigth+sectionNum*(heigth+5);
    if (accountHeight>self.scrollView.height) {
        self.scrollView.contentSize = CGSizeMake(0, accountHeight);
    }
}
- (void)btnClick:(UIButton *)button
{
    NSInteger num = button.tag-10;
    DetailViewController *ctrl = [[DetailViewController alloc] init];
    CollectItem *item = _savedDateArray[num];
    ctrl.myId = item.myId;
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
