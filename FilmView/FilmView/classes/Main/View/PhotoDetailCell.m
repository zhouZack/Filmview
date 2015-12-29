//
//  PhotoDetailCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/27.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "PhotoDetailCell.h"

@implementation PhotoDetailCell
{
    UIImageView *_imageViewph;
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageViewph = [[UIImageView alloc] init];
        _imageViewph.size = CGSizeMake(UIScreenWidth, UIScreenHeight/3);
        _imageViewph.center = CGPointMake(UIScreenWidth/2, (UIScreenHeight-108)/2);
        [self.contentView addSubview:_imageViewph];
    }
    return self;
}

- (void)config:(NSDictionary *)dict
{
    [_imageViewph sd_setImageWithURL:[NSURL URLWithString:[ToolUtil changeDeleteImageStringWith:dict[@"olink"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
