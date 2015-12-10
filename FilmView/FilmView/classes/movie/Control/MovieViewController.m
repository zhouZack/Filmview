//
//  MovieViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MovieViewController.h"
#import "AppDelegate.h"
@interface MovieViewController ()

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self setNav];
}

- (void)setNav{
    [self addtitleWithName:@"热映"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:YES frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    
}
- (void)changeLeft
{
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
