//
//  MainViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MainViewController.h"
#import "EnterportViewController.h"
#import "MovieViewController.h"
#import "SpecialTopicViewController.h"
#import "InformationViewController.h"


@interface MainViewController ()

@property (nonatomic ,strong)UIView *tabBarView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
    MovieViewController*move = [[MovieViewController alloc] init];
    [self addChildWith:move image:@"tab_home@3x" selectImage:@"tab_homeH@3x" title:@"电影"];
    
    InformationViewController *information = [[InformationViewController alloc] init];
    [self addChildWith:information image:@"tab_cinema@3x" selectImage:@"tab_cinemaH@3x" title:@"影讯"];
    
    SpecialTopicViewController *sepcial = [[SpecialTopicViewController alloc] init];
    [self addChildWith:sepcial image:@"tab_event@3x" selectImage:@"tab_eventH@3x" title:@"专题"];
    
    EnterportViewController *enter = [[EnterportViewController alloc] init];
    [self addChildWith:enter image:@"tab_library@3x" selectImage:@"tab_libraryH@3x" title:@"片库"];
    
    [self createTabBarView];
}
- (void)createTabBarView
{
    /*
     Button tag ＝20+i;
     UIimageViwe tag = 30+i;
     Label tag = 40+i;
     */
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreenHeight-49, UIScreenWidth, 49)];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    
    NSArray *imageArr = @[@"tab_home@3x",@"tab_cinema@3x",@"tab_event@3x",@"tab_library@3x"];
    
    NSArray *titleArr = @[@"电影",@"影讯",@"专题",@"片库"];
    CGFloat width = UIScreenWidth/4;
    for (int i =0; i<imageArr.count; i++) {
        
        UIButton *btnB = [[UIButton alloc] initWithFrame:CGRectMake(width*i, 0, width, CGRectGetHeight(_tabBarView.bounds))];
        [btnB addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:btnB];
        btnB.tag = 20+i;
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArr[i]]];
        imageV.size = CGSizeMake(25, 25);
        imageV.top = 5;
        imageV.centerX = btnB.width/2;
        [btnB addSubview:imageV];
        imageV.tag = 30+i;
        UILabel *labelL = [ToolUtil labelwithFrame:CGRectMake(0, imageV.bottom+3, btnB.width, 15) font:12 text:titleArr[i] color:[UIColor colorWithRed:123/255.0f green:123/255.0f blue:123/255.0f alpha:1]];
        labelL.textAlignment = NSTextAlignmentCenter;
        [btnB addSubview:labelL];
        labelL.tag =40+i;
        self.selectedIndex = 0;
        
        if (i == 0) {
            imageV.image = [UIImage imageNamed:@"tab_homeH@3x"];
            labelL.textColor = [UIColor blueColor];
        }
    }
    [self.view addSubview:_tabBarView];
    
}
- (void)tabBarButtonClick:(UIButton *)button
{
    NSArray *imageArr = @[@"tab_home@3x",@"tab_cinema@3x",@"tab_event@3x",@"tab_library@3x"];
    NSArray *selectImageArr =@[@"tab_homeH@3x",@"tab_cinemaH@3x",@"tab_eventH@3x",@"tab_libraryH@3x"];
//    NSLog(@"%ld",self.selectedIndex);
    NSInteger num = button.tag-20;
    NSLog(@"%ld",num);
    UIImageView *lastImageView = (UIImageView*)[_tabBarView viewWithTag:30+self.selectedIndex];
    lastImageView.image = [UIImage imageNamed:imageArr[self.selectedIndex]];
    
    UILabel * lastLabel = (UILabel*)[_tabBarView viewWithTag:40+self.selectedIndex];
    lastLabel.textColor = [UIColor colorWithRed:123/255.0f green:123/255.0f blue:123/255.0f alpha:1];
    NSLog(@"%@",lastLabel.text);
    
    
    UIImageView *imageViewCurrent = (UIImageView*)[button viewWithTag:num+30];
    imageViewCurrent.image = [UIImage imageNamed:selectImageArr[num]];
    UILabel *labelCurrent = (UILabel *)[button viewWithTag:num+40];
    labelCurrent.textColor = [UIColor blueColor];
    self.selectedIndex = num;
    
}
- (void)addChildWith:(UIViewController*)ctrl image:(NSString*)image selectImage:(NSString*)selectImage title:(NSString*)title;
{
    ctrl.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
    
    ctrl.title = title;
    NSMutableDictionary *normalDictionary = [[NSMutableDictionary alloc] init];
    normalDictionary[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0f green:123/255.0f blue:123/255.0f alpha:1];
    NSMutableDictionary *selectDictionary = [[NSMutableDictionary alloc] init];
    selectDictionary[NSForegroundColorAttributeName]= [UIColor blueColor];
    
    [ctrl.tabBarItem setTitleTextAttributes:normalDictionary forState:UIControlStateNormal];
    [ctrl.tabBarItem setTitleTextAttributes:selectDictionary forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTabBar
{
    self.tabBarView.hidden = NO;
    
}
-(void)hideTabBar
{
    self.tabBarView.hidden = YES;
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
