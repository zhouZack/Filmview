//
//  EnterportViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "EnterportViewController.h"
#import "EnterpoDeViewController.h"
@interface EnterportViewController ()

@end

@implementation EnterportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(245, 245, 245);

    [self setNav];
    [self createBtn];
}
- (void)setNav{
    
    [self addtitleWithName:@"片库"];
    [self addUIbarButtonItemWithImage:@"menu@2x" left:NO frame:CGRectMake(0, 0, 20, 20) target:self action:@selector(changeLeft)];
    
}
- (void)createBtn
{
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, UIScreenWidth-30, 30)];
    placeLabel.textAlignment = NSTextAlignmentLeft;
    placeLabel.text = @"地区";
    [self.view addSubview:placeLabel];
    
    CGFloat width = (UIScreenWidth-60)/4;
    CGFloat height = 40;
    
    NSArray *categoryArray = @[@"剧情", @"喜剧", @"爱情", @"动画", @"动作", @"恐怖", @"惊悚", @"悬疑", @"冒险", @"科幻", @"犯罪", @"战争", @"纪录片"];
    for ( int i = 0; i< categoryArray.count; i++) {
        NSInteger section = i/4;
        NSInteger row = i%4;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+row*(width+10), placeLabel.bottom+10+section*(height+10), width, height)];
        [btn setTitle:categoryArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 3001+i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
    }
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 260, UIScreenWidth-30, 30)];
    categoryLabel.textAlignment = NSTextAlignmentLeft;
    categoryLabel.text = @"类型";
    [self.view addSubview:categoryLabel];
    
    NSArray *regionArray = @[@"大陆", @"美国", @"法国", @"英国", @"日本", @"韩国", @"印度", @"泰国", @"香港", @"德国", @"其他"];
    for (int i = 0; i<regionArray.count; i++) {
        NSInteger section = i/4;
        NSInteger row = i%4;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+row*(width+10), categoryLabel.bottom+10+section*(height+10), width, height)];
        [btn setTitle:regionArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(placeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 2002+i;
        [self.view addSubview:btn];
    }
    
}
- (void)placeBtnClick:(UIButton *)button
{
    NSInteger inte = button.tag-2000;
    if (inte ==12) {
        inte=100;
    }
    EnterpoDeViewController *enter = [[EnterpoDeViewController alloc] init];
    enter.parameter1 = @"source";
    enter.parameter2 = @"src";
    enter.parameterNum = inte;
    [self.navigationController pushViewController:enter animated:YES];
}
- (void)categoryBtnClick:(UIButton*)button
{
    NSInteger inte = button.tag -3000;
    EnterpoDeViewController *enter = [[EnterpoDeViewController alloc] init];
    enter.parameter1 = @"category";
    enter.parameter2 = @"cat";
    enter.parameterNum = inte;
     [self.navigationController pushViewController:enter animated:YES];
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
