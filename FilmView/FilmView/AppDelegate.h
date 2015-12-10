//
//  AppDelegate.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"

#import "Test2ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) MainViewController *mainTabBarController;
@property (strong, nonatomic) Test2ViewController *testVC2;
@end

