//
//  PhotoViewControl.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/25.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "PhotoViewControl.h"
#import "PhotoCell.h"
#import "PhotoDetailControl.h"
#import "MyLayout.h"

@interface PhotoViewControl ()<UICollectionViewDataSource,UICollectionViewDelegate,MyLayoutDelegate>

@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)NSMutableArray *dateSource;
@property (nonatomic ,strong)NSMutableArray *heightArr;//保存cell高度的数组
@end

@implementation PhotoViewControl

- (NSMutableArray*)dateSource
{
    if (_dateSource ==nil) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}
- (NSMutableArray *)heightArr
{
    if (_heightArr ==nil) {
        _heightArr = [[NSMutableArray alloc] init];
    }
    return _heightArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCollection];
    [self reloadData];
     NSLog(@"%@",self.myId);
}

- (void)createCollection
{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat width = (UIScreenWidth-31)/4;
//    CGFloat heith = 120;
//    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    layout.itemSize = CGSizeMake(width, heith);
//    layout.minimumInteritemSpacing = 5;
//    layout.minimumLineSpacing = 5;
    
    MyLayout *myLayout = [[MyLayout alloc] initWithSectionInsets:UIEdgeInsetsMake(5, 5, 5, 5) itemSpace:5 lineSpace:5];
    
    myLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-108) collectionViewLayout:myLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview: _collectionView];
}
- (void)reloadData
{
    
    __weak __typeof(self)weakSelf = self;
    [HttpRequestHelper photoControlWithMyId:self.myId success:^(id responseObject){
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *arrayImg = responseObject[@"data"];
            if (arrayImg.count != 0) {
                for (NSDictionary *dict in arrayImg) {
                    [weakSelf.dateSource addObject:dict];
                }
            }
            [weakSelf addtitleWithName:[NSString stringWithFormat:@"%ld张剧照",arrayImg.count]];
            [weakSelf.collectionView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
}

#pragma mark-UICollcetionView代理协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dateSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSDictionary*dict = _dateSource[indexPath.item];
    [cell config:dict];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailControl *detail = [[PhotoDetailControl alloc] init];
    detail.dateSource = self.dateSource;
    detail.photoNumber = indexPath.item;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MyLayout代理
-(int)columnsInCollectionView
{
    return 3;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
//    DataModel *model = _dataArray[indexPath.item];
    return 150+arc4random()%40;
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
