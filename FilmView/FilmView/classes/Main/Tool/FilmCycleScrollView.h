//
//  FilmCycleScrollView.h
//  FilmView
//
//  Created by Zc_zhou on 16/1/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilmCycleScrollView;
@protocol FilmCycleScrollViewDelegate <NSObject>

// 代理方法 通知代理方点击的下标
- (void)cycleScrollView:(FilmCycleScrollView *)cycleScrollView DidTapImageView:(NSInteger)index;

@end

@interface FilmCycleScrollView : UIView
// 初始化
- (id)initWithFrame:(CGRect)frame;
// 设置数据源 没有自动滚动功能 不创建定时器
- (void)setImageUrlNames:(NSArray *)ImageUrlNames;
// 设置数据源 和 自动滚动时间 能够自动滚动
- (void)setImageUrlNames:(NSArray *)ImageUrlNames animationDuration:(NSTimeInterval)animationDuration;

// 内部使用的是系统默认的pageControll属性 如有需要 自行设置
@property (nonatomic ,weak) UIPageControl *scrollPage;

// 代理
@property (nonatomic ,weak) id <FilmCycleScrollViewDelegate> delegate;

@end
