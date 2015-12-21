//
//  InformationCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "InformationCell.h"
@interface InformationCell ()

@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UIView *viewImg;


@end

@implementation InformationCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, UIScreenWidth-14, 25)];
        [self.contentView addSubview:_titleLabel];
        _viewImg = [[UIView alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+10, _titleLabel.width, 90)];
        [self.contentView addSubview:_viewImg];
    }
    
    return self;
}
- (void)configWithModel:(InformationModel *)model
{
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = model.title;
    
    CGFloat width = (_viewImg.width-20)/3;
    CGFloat heigrh = _viewImg.height;
    if (model.images.count) {
        for (int i =0 ;i<model.images.count;i++) {
            NSDictionary*dict = model.images[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width+10), 0, width, heigrh)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"url"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [_viewImg addSubview:imageView];
        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
