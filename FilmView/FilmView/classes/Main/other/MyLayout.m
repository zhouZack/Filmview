//
//  MyLayout.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MyLayout.h"


@implementation MyLayout
{
    //布局
    UIEdgeInsets _sectionInsets;
    CGFloat _itemSpace;
    CGFloat _lineSpace;
    
    //存储每一列当前的高度
    NSMutableArray *_columnArray;
    //列数
    int _column;
    
    //存储所有cell的frame
    NSMutableArray *_attrArray;
}
-(instancetype)initWithSectionInsets:(UIEdgeInsets)sectionInsets itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace
{
    if (self = [super init]) {
        //赋值
        _sectionInsets = sectionInsets;
        _itemSpace = itemSpace;
        _lineSpace = lineSpace;
        
        
        _column = 2;
    }
    return self;
}

//每次重新布局的时候会调用这个方法
-(void)prepareLayout
{
    [super prepareLayout];
    
    //获取列数
    if (self.delegate) {
        _column = [self.delegate columnsInCollectionView];
    }
    
    //初始化数组
    _columnArray = [NSMutableArray array];
    
    for (int i=0; i<_column; i++)
    {
        NSNumber *n = [NSNumber numberWithFloat:_sectionInsets.top];
        [_columnArray addObject:n];
    }
    
    //计算每个cell的frame
    _attrArray = [NSMutableArray array];
    
    //一共有多少cell
    NSInteger cellCnt = [self.collectionView numberOfItemsInSection:0];
    
    //计算宽度
    CGFloat cellW = (self.collectionView.bounds.size.width-_sectionInsets.left-_sectionInsets.right-_itemSpace*(_column-1))/_column;
    for (int i=0; i<cellCnt; i++) {
        
        //x
        //获取在第几列
        NSInteger lowIndex = [self lowestColumnIndex];
        CGFloat x = _sectionInsets.left+(cellW+_itemSpace)*lowIndex;
        
        //y
        CGFloat y = [_columnArray[lowIndex] floatValue];
        
        //w
        //cellW
        
        //h
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        CGFloat height = [self.delegate heightForCellAtIndexPath:indexPath];
        
        
        _columnArray[lowIndex] = [NSNumber numberWithFloat:y+height+_lineSpace];
        
        //创建存储frame的对象
        CGRect frame = CGRectMake(x, y, cellW, height);
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = frame;
        
        //添加到数组中
        [_attrArray addObject:attr];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attrArray;
}

//设置最大滚动范围
- (CGSize)collectionViewContentSize
{
    NSInteger index = [self highestColumnIndex];
    CGFloat h = [_columnArray[index] floatValue];
    return CGSizeMake(self.collectionView.bounds.size.width, h);
}

//获取最高的列数
- (NSInteger)highestColumnIndex
{
    NSInteger index = -1;
    CGFloat height = CGFLOAT_MIN;
    
    for (NSInteger i=0; i<_columnArray.count; i++) {
        NSNumber *n = _columnArray[i];
        if (n.floatValue > height) {
            height = n.floatValue;
            index = i;
        }
    }
    return index;
}

//获取当前最低的列数
- (NSInteger)lowestColumnIndex
{
    /*
     _columnArray  {30,20,50}
     30  height=30  index=0
     20  height=20  index=1
     50
     */
    CGFloat height = CGFLOAT_MAX;
    NSInteger index = -1;
    for (NSInteger i=0; i<_columnArray.count; i++) {
        
        NSNumber *n = _columnArray[i];
        if (n.floatValue < height) {
            height = n.floatValue;
            index = i;
        }
        
    }
    
    return index;
    
}

@end
