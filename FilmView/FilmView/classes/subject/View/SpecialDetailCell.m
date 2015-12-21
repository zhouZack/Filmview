//
//  SpecialDetailCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SpecialDetailCell.h"
@interface SpecialDetailCell ()

@property (nonatomic ,strong)UIImageView *imageViewSp;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *starLabel;
@property (nonatomic ,strong)UILabel *containLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *pointLabel;

@end


@implementation SpecialDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageViewSp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 90)];
        [self.contentView addSubview:_imageViewSp];
        _starLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewSp.right +5, _imageViewSp.top, UIScreenWidth-130, 20)];
        [self.contentView addSubview:_starLabel];
        _containLabel = [[UILabel alloc] initWithFrame:CGRectMake(_starLabel.left, _starLabel.bottom+5, _starLabel.width, _starLabel.height)];
        [self.contentView addSubview:_containLabel];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_containLabel.left, _containLabel.bottom+5, _containLabel.width, _containLabel.height)];
        [self.contentView addSubview:_timeLabel];
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(_starLabel.right, 40, 30, 30)];
        [self.contentView addSubview:_pointLabel];
    }
    
    return self;
}

- (void)configWithModel:(SpecialDetailModel*)model
{
    _titleLabel.textAlignment = _starLabel.textAlignment = _containLabel.textAlignment = _timeLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _starLabel.font = _containLabel.font = _timeLabel.font = [UIFont systemFontOfSize:13];
    _pointLabel.textColor = [UIColor orangeColor];
    
    [_imageViewSp sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _titleLabel.text = model.nm;
    _starLabel.text = model.star;
    _containLabel.text = model.cat;
    _timeLabel.text = model.rt;
    _pointLabel.text = [NSString stringWithFormat:@"%@",model.sc];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
