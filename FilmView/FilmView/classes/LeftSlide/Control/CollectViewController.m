//
//  CollectViewController.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectItem.h"
#import "DetailViewController.h"
#import "CollectControlCell.h"

@interface CollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,assign)NSInteger num;
@property (nonatomic ,strong)NSArray *savedDateArray;
@property (nonatomic ,strong)UIScrollView *scrollView;

@property (nonatomic ,strong)UICollectionView *collectionView;


@end

@implementation CollectViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self receiveDate];

}
- (void)receiveDate
{
    self.savedDateArray = [[FilmCoreDateHelper share] selectData:0 andOffset:0];
    [self.collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addtitleWithName:@"我的收藏"];
    [self createCollectionView];

}
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = CGSizeMake(100*kRatio, 160*kRatio);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108)collectionViewLayout:layout];
    _collectionView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectControlCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:_collectionView];
    
}

#pragma mark-UICollectionView代理协议
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _savedDateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectControlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell config:_savedDateArray[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *ctrl = [[DetailViewController alloc] init];
    CollectItem *item = _savedDateArray[indexPath.item];
    ctrl.myId = item.myId;
    [self.navigationController pushViewController:ctrl animated:YES];
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
