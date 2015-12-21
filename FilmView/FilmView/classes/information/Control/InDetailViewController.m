//
//  InDetailViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/21.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "InDetailViewController.h"
#import "InDetailModel.h"
@interface InDetailViewController ()

@property (nonatomic ,copy)NSString *titleName;
@property (nonatomic ,copy)NSString *detailUrl;

@end

@implementation InDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.myId);
    [self reloadData];
}
- (void)setSubView
{
    UILabel *titleLabel = [ToolUtil labelwithFrame:CGRectMake(0, 0, UIScreenWidth, 60) font:22 text:self.titleName color:[UIColor blackColor]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    UIWebView*wbVIew=[[UIWebView alloc] initWithFrame:CGRectMake(5, titleLabel.bottom, UIScreenWidth-10, UIScreenHeight-108-titleLabel.height)];
    wbVIew.scrollView.bounces = NO;
    [wbVIew loadHTMLString:self.detailUrl baseURL:nil];

    [self.view addSubview:wbVIew];
    
    
}
- (void)reloadData
{
    __weak __typeof(self)weakSelf = self;
    [HttpRequestHelper informationDetailWithMyId:self.myId success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.titleName = responseObject[@"data"][@"news"][@"title"];
            weakSelf.detailUrl = responseObject[@"data"][@"news"][@"text"];
            [weakSelf setSubView];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
