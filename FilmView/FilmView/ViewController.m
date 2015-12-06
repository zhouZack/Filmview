//
//  ViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] init];
    view.top = 10;
    view.left = 100;
    view.size = CGSizeMake(50, 100);
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
