//
//  UIViewController+FlimExtension.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/13.
//  Copyright © 2015年 Apple. All rights reserved.
//  RGBColor(42, 162, 239)

#import "UIViewController+FlimExtension.h"

@implementation UIViewController (FlimExtension)

-(void)viewDidLoad{
    if (IOSVersion(7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setBackgroundColor:RGBColor(249, 212, 9)];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setBarTintColor:RGBColor(249, 212, 9)];
        
    }
    
}
@end
