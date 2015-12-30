//
//  StarView.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/30.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "StarView.h"

@implementation StarView
{
    UIView *_starVIew;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createStarView];
    }
    return self;
    
}
- (void)createStarView
{
    CGFloat width = 90;
    CGFloat heigth = 15;
    
    _starVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
    _starVIew.contentMode = UIViewContentModeLeft;
    _starVIew.clipsToBounds = YES;
    [self addSubview:_starVIew];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
    bgImageView.image = [UIImage imageNamed:@"star_normal"];
    [self addSubview:bgImageView];
    
    UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
    upImageView.image = [UIImage imageNamed:@"star_press"];
    [_starVIew addSubview:upImageView];
    
}
-(void)setStarView:(double)num
{
    CGRect frame = _starVIew.frame;
    frame.size.width = num/10*90;
    _starVIew.frame = frame;
    
    
}

















@end
