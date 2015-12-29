//
//  SearchViewCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SearchViewCell.h"
@interface SearchViewCell ()

@property (nonatomic ,strong)UIImageView *imageViewSe;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *categoryLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *pointLabel;

@end

@implementation SearchViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageViewSe = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 90)];
        [self.contentView addSubview:_imageViewSe];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewSe.right+5, _imageViewSe.top, UIScreenWidth-145, 25)];
        [self.contentView addSubview:_titleLabel];
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+20, _titleLabel.width, 20)];
        [self.contentView addSubview:_categoryLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_categoryLabel.left, _categoryLabel.bottom+5, _categoryLabel.width, 20)];
        [self.contentView addSubview:_timeLabel];
        
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.right, _imageViewSe.top, 60, 30)];
        [self.contentView addSubview:_pointLabel];
        
    }
    return self;
}

- (void)config:(SearchModel*)model
{
    
    _titleLabel.textAlignment = _categoryLabel.textAlignment = _timeLabel.textAlignment = NSTextAlignmentLeft;
    
    _timeLabel.font = _categoryLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = _categoryLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    
    _titleLabel.text = model.nm;
    _categoryLabel.text = model.cat;
    _timeLabel.text = model.rt;
    [_imageViewSe sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _pointLabel.textColor = [UIColor orangeColor];
    _pointLabel.font = [UIFont boldSystemFontOfSize:20];

    
    CGFloat num = [model.sc floatValue];
    
    _pointLabel.text = [NSString stringWithFormat:@"%.1lf分",num];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
