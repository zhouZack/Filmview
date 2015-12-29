//
//  EnterPortCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "EnterPoCell.h"

@interface EnterPoCell ()

@property (nonatomic ,strong)UIImageView *imageViewEn;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *categoryLabel;
@property (nonatomic ,strong)UILabel *englishLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *pointLabel;

@end
@implementation EnterPoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageViewEn = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 90)];
        [self.contentView addSubview:_imageViewEn];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewEn.right+7, _imageViewEn.top, UIScreenWidth-140, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, 15)];
        _englishLabel.textAlignment = NSTextAlignmentLeft;
        _englishLabel.font = [UIFont systemFontOfSize:12];
        _englishLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_englishLabel];
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(_englishLabel.left, _englishLabel.bottom, _englishLabel.width, _englishLabel.height)];
        _categoryLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        _categoryLabel.textAlignment = NSTextAlignmentLeft;
        _categoryLabel.font = _englishLabel.font;
        [self.contentView addSubview:_categoryLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_categoryLabel.left, _categoryLabel.bottom, _categoryLabel.width, _categoryLabel.height)];
        _timeLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_timeLabel];
        
        
        
    }
    
    return self;
}

-(void)config:(EnterPoModel *)model
{
    [_imageViewEn sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _titleLabel.text = model.nm;
    _englishLabel.text = model.enm;
    _categoryLabel.text = model.cat;
    _timeLabel.text = model.rt;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
