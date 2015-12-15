//
//  EnterportViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "EnterportViewController.h"

@interface EnterportViewController ()

@end

@implementation EnterportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNav];
}
- (void)setNav{
    [self addtitleWithName:@"片库"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:YES frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    
}
- (void)changeLeft{
    [self changeLeftList];
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