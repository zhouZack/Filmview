//
//  UIViewController+Extension.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//
#define IOSVersion(_version) ([[[UIDevice currentDevice] systemVersion] doubleValue] >= _version)

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

-(void)viewDidLoad{
    if (IOSVersion(7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setBackgroundColor:RGBColor(42, 162, 239)];
        [self.navigationController.navigationBar setTintColor:RGBColor(42, 162, 239)];
        [self.navigationController.navigationBar setBarTintColor:RGBColor(42, 162, 239)];
    }
    
}
@end
