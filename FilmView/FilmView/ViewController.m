//
//  ViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (nonatomic ,strong)UITextField *name;

@property (nonatomic ,strong)UITextField *passWord;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
  
   
    
}
- (void)btnClick:(UIButton*)btn
{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_passWord resignFirstResponder];
    [_name resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
