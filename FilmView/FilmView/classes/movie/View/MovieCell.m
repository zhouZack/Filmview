//
//  MovieCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/12.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MovieCell.h"
@interface MovieCell ()



@end

@implementation MovieCell
{
    UILabel *_titlelabel;           // 电影名
    UILabel *_descLabel;            // 简介
    UILabel *_timeLabel;            // 上映时间
    UILabel *_integerNumLabel;      // 评分的整数位
    UILabel *_decimalNumLabel;      // 评分的小数位
    UILabel *_actorLabel;           // 演员
    UIImageView *_threeDImageView;  // 3D
    UIImageView *_imaxImageView;    // IMAX
    UILabel *_twoDLabel;  // 中国巨幕
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 71.5, 100)];
        [self.contentView addSubview:_thumbImageView];

        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + UIScreenWidth / 32, 12, UIScreenWidth - 90 - 30, 16)];
        [self.contentView addSubview:_titlelabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + UIScreenWidth / 32 + 10 + 3, 33, UIScreenWidth - 100, 13)];
        [self.contentView addSubview:_descLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + UIScreenWidth / 32, 51, 220, 14)];
        [self.contentView addSubview:_timeLabel];
        
        _integerNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_integerNumLabel];
        
        _decimalNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_decimalNumLabel];
        
        _actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + UIScreenWidth / 32, 70, UIScreenWidth - 100, 15)];
        [self.contentView addSubview:_actorLabel];

    }
    return self;
}

- (void)configComingCell:(MovieModel *)item
{
    // 电影图片
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:item.img]];
    // 设置电影名字的大小
    _titlelabel.text = item.nm;
    _titlelabel.font = [UIFont boldSystemFontOfSize:16];
    _titlelabel.numberOfLines = 1;
    
    [self commonConfig:item];

}
- (void)configCell:(MovieModel *)item
{
    // 电影图片
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:item.img]];
    
    // 电影名字
    /**
     *  计算文字的宽度
     *
     第一个参数:文字显示的最大范围
     第二个参数:计算文字宽度的方式
     第三个参数:文字的属性(字体大小等等)
     第四个参数:上下文(nil)
     */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    
    CGRect titleFrame = [item.nm boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    //TODO: 自动调节宽度
    if (titleFrame.size.width > UIScreenWidth - 80 - UIScreenWidth/16 - 28) {
        titleFrame.size.width = UIScreenWidth - 80 - UIScreenWidth/16 - 35;
    }
    CGFloat titleW = titleFrame.size.width;
    
    // 设置电影名字的大小
    _titlelabel.text = item.nm;
    _titlelabel.font = [UIFont boldSystemFontOfSize:16];
    _titlelabel.numberOfLines = 1;
    
    CGRect descFrame = _titlelabel.frame;
    descFrame.size.width = titleW;
    _titlelabel.frame = descFrame;
    
    CGFloat firstRowX = 80 + UIScreenWidth / 32 + titleW;
    // 评分
    _integerNumLabel.frame = CGRectMake(firstRowX + UIScreenWidth / 32, 10, 13, 18);
    _integerNumLabel.font = [UIFont systemFontOfSize:24];
    
    _integerNumLabel.text = [[NSString stringWithFormat:@"%f", item.mk] substringToIndex:1];
    _integerNumLabel.textColor = [UIColor colorWithRed:99/255.0 green:154/255.0 blue:30/255.0 alpha:1.000];
    
    _decimalNumLabel.frame = CGRectMake(firstRowX + UIScreenWidth / 32 + 13 + 3, 15, 16, 13);
    _decimalNumLabel.attributedText = [[NSAttributedString alloc] initWithString:[[[NSString stringWithFormat:@"%f", item.mk] substringFromIndex:1] substringToIndex:2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor colorWithRed:99/255.0 green:154/255.0 blue:30/255.0 alpha:1.000]}];
    [self commonConfig:item];
    
    
}
- (void)commonConfig:(MovieModel*)item{
    // 简述文字
    UIImageView *quetaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80 + UIScreenWidth / 32, 34, 10, 9)];
    quetaImageView.image = [UIImage imageNamed:@"v10_quot"];
//    [self.contentView addSubview:quetaImageView];
    _descLabel.attributedText = [[NSAttributedString alloc] initWithString:item.scm attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0.53 blue:0 alpha:1]}];
    
    // 上映时间  [item.rt substringWithRange:NSMakeRange(5, 2)]：从第5个开始截取2个字符
    //NSMakeRange(5, 2):相当于NSRange range,range.length=2,range.location=5;
    NSString *dateStr = [NSString stringWithFormat:@"%@月%@日上映/%@分钟", [item.rt substringWithRange:NSMakeRange(5, 2)], [item.rt substringWithRange:NSMakeRange(8, 2)], item.dur];
    _timeLabel.attributedText = [[NSAttributedString alloc] initWithString:dateStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    // 演员
    if (item.star) {
        NSMutableString *actorStr = [NSMutableString stringWithString:item.star];
        [actorStr replaceOccurrencesOfString:@"," withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, item.star.length)];
        _actorLabel.attributedText = [[NSAttributedString alloc] initWithString:actorStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        
    }
    CGFloat versionX = 80 + UIScreenWidth / 32;
    
    
//    if ([item.ver rangeOfString:@"3D"].location != NSNotFound) {
//        _threeDImageView = [[UIImageView alloc] initWithFrame:CGRectMake(versionX, 90, 20, 15)];
//        _threeDImageView.image = [UIImage imageNamed:@"icon_hot_show_3D"];
//        [self.contentView addSubview:_threeDImageView];
//        
//        versionX += 20 + 5;
//    }
//    if ([item.ver rangeOfString:@"IMAX"].location != NSNotFound) {
//        _imaxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(versionX, 90, 30, 15)];
//        _imaxImageView.image = [UIImage imageNamed:@"icon_hot_show_IMAX"];
//        [self.contentView addSubview:_imaxImageView];
//    }
//    //FIX-
//    if ([item.ver rangeOfString:@"IMAX"].location == NSNotFound && [item.ver rangeOfString:@"3D"].location == NSNotFound) {
//        _twoDLabel = [[UILabel alloc] initWithFrame:CGRectMake(versionX, 90, 20, 15)];
//        _twoDLabel.layer.cornerRadius = 1;
//        _twoDLabel.clipsToBounds = YES;
//        _twoDLabel.layer.borderColor = [UIColor colorWithWhite:0.2 alpha:1].CGColor;
//        _twoDLabel.layer.borderWidth = 0.5;
//        _twoDLabel.layer.cornerRadius = 2;
//        _twoDLabel.clipsToBounds = YES;
//        
//        _twoDLabel.attributedText = [[NSAttributedString alloc] initWithString:@"2D" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:9], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.3 alpha:1]}];
//        _twoDLabel.textAlignment = 1;
//        [self.contentView addSubview:_twoDLabel];
//    }


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
