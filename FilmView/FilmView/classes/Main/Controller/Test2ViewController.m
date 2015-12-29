//
//  Test2ViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/9.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic ,assign)CGFloat scalef;
@property (nonatomic ,strong)UIView *containView;
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation Test2ViewController


-(instancetype)initWithLeftView:(UIViewController *)leftVC MainView:(UIViewController *)mainVC{
    if (self = [super init]) {
        self.mainVC = mainVC;
        self.leftVC = leftVC;
        
        UIView *view = [[UIView alloc] initWithFrame:self.leftVC.view.bounds];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self.leftVC.view addSubview:view];
        self.containView = view;
        [self.view addSubview:self.leftVC.view];
        
        //拿出leftVC中的tableView设置他的大小和位置
        for (id tableVIew in self.leftVC.view.subviews) {
            if ([tableVIew isKindOfClass:[UITableView class]]) {
                self.tableView = tableVIew;
            }
        }
        self.tableView.frame = CGRectMake(0, 0, UIScreenWidth-kMainPageDistance, UIScreenHeight);
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
        self.tableView.center = CGPointMake(kLeftCenterX, UIScreenHeight/2);
        self.tableView.backgroundColor = [UIColor clearColor];
        
        //给mainVC添加滑动手势
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handPan:)];
        self.panGesture.delegate = self;
        [self.mainVC.view addGestureRecognizer:self.panGesture];
        self.panGesture.cancelsTouchesInView = YES;
        [self.view addSubview:self.mainVC.view];
        
        self.closed = YES;
    }
    return self;
}

- (void)handPan:(UIPanGestureRecognizer*)pan{
    
    CGPoint point = [pan translationInView:self.view];
    
    _scalef = point.x*vSpeedFloat +_scalef;
    
    BOOL allowRemove = YES;
    if (((self.mainVC.view.left <=0)&&(_scalef <= 0))||((self.mainVC.view.left >= (UIScreenWidth - kMainPageDistance))&&(_scalef >= 0))) {
        allowRemove = NO;
        _scalef = 0;
    }
    
    if (allowRemove && (self.mainVC.view.left >= 0) && (self.mainVC.view.left <= (UIScreenWidth - kMainPageDistance))) {
        //改变MainVC的位置
        CGFloat mainCenterX = self.mainVC.view.centerX +point.x*vSpeedFloat;
        self.mainVC.view.center = CGPointMake(mainCenterX, self.view.centerY);
        //改变MainVC的大小
        CGFloat scale = 1-(1-kMainPageScale)*(self.mainVC.view.left)/(UIScreenWidth - kMainPageDistance);
        self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
        //改变tableView的位置和大小
        CGFloat tableCenterX = kLeftCenterX +((UIScreenWidth -kMainPageDistance)/2-kLeftCenterX)*(self.mainVC.view.left)/(UIScreenWidth - kMainPageDistance);
        self.tableView.center = CGPointMake(tableCenterX, UIScreenHeight/2);
        CGFloat tableScale = 0.2 + 0.8*(self.mainVC.view.left)/(UIScreenWidth - kMainPageDistance);
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, tableScale, tableScale);
        
        //改变蒙版的通明度
        self.containView.alpha = kLeftAlpha - kLeftAlpha * (self.mainVC.view.left)/(UIScreenWidth - kMainPageDistance);
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) >= vCouldChangeDeckStateDistance) {
            if (self.closed == YES) {
                [self openLeftView];
            }else{
                [self closedLeftView];
            }
            
        }else{
            if (self.closed == YES) {
                [self closedLeftView];
            }else{
                [self openLeftView];
            }
        }
    }
    
}
- (void)openLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.center = kMainPageCenterRight;
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kMainPageScale, kMainPageScale);
    _scalef = 0;
    self.closed = NO;
    
    self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    self.tableView.center = CGPointMake(kMainPageDistance+(UIScreenWidth-kMainPageDistance)/2, UIScreenHeight/2);
    
    self.containView.alpha = 0;
    [UIView commitAnimations];
    [self addSignleTap];
}
- (void)closedLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.center = CGPointMake(self.view.centerX, self.view.centerY);
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    _scalef = 0;
    self.closed = YES;
    self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    self.tableView.center = CGPointMake(30, UIScreenHeight/2);
    self.containView.alpha = kLeftAlpha;
    [UIView commitAnimations];
    [self removeSignleTap];
}

- (void)addSignleTap{
    
    for (UIButton *btn in [self.mainVC.view subviews]) {
        btn.userInteractionEnabled = NO;
    }
    if (self.tapGesture ==nil) {
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
        [self.mainVC.view addGestureRecognizer:self.tapGesture];
    }
    
}
- (void)removeSignleTap{
    for (UIButton *btn in [self.mainVC.view subviews]) {
        btn.userInteractionEnabled = YES;
    }
    [self.mainVC.view removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
}
- (void)handTap:(UITapGestureRecognizer*)tap{
    [self closedLeftView];
}

-(void)setPanEnable:(BOOL)enabled{
    self.panGesture.enabled = enabled;
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view.tag == 1000) {
        return NO;
    }
    else{
        return YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
