//
//  CollectControlCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/25.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "CollectControlCell.h"

@implementation CollectControlCell

{
    UIImageView *_titleImageView;
    UILabel     *_titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100*kRatio, 140*kRatio)];
        [self.contentView addSubview:_titleImageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.left, _titleImageView.bottom, _titleImageView.width, 20*kRatio)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
- (void)config:(CollectItem *)Item{
    
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:Item.image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _titleLabel.text = Item.name;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    
}

@end
