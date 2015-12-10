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

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    MovieViewController*move = [[MovieViewController alloc] init];
    [self addChildWith:move image:@"tab_home@3x" selectImage:@"tab_homeH@3x" title:@"电影"];
    
    InformationViewController *information = [[InformationViewController alloc] init];
    [self addChildWith:information image:@"tab_cinema@3x" selectImage:@"tab_cinemaH@3x" title:@"影讯"];
    
    SpecialTopicViewController *sepcial = [[SpecialTopicViewController alloc] init];
    [self addChildWith:sepcial image:@"tab_event@3x" selectImage:@"tab_eventH@3x" title:@"专题"];
    
    EnterportViewController *enter = [[EnterportViewController alloc] init];
    [self addChildWith:enter image:@"tab_library@3x" selectImage:@"tab_libraryH@3x" title:@"片库"];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
