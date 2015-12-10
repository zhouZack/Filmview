//
//  BaseViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addtitleWithName:(NSString *)name{
    self.navigationItem.title = name;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}
-(void)addUIbarButtonItemWithImage:(NSString *)image left:(BOOL)left frame:(CGRect)frame target:(id)target action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (left == YES) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationController.navigationItem.rightBarButtonItem = item;
    }
}
-(void)changeLeftList{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (app.testVC2.closed ==YES) {
        [app.testVC2 openLeftView];
    }else{
        [app.testVC2 closedLeftView];
    }
    
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
