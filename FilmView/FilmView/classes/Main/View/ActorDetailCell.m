//
//  ActorDetailCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ActorDetailCell.h"

@implementation ActorDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 100)];
        [self.contentView addSubview:_photoImage];
        _nameLabel = [ToolUtil labelwithFrame:CGRectMake(_photoImage.right+10, _photoImage.top, UIScreenWidth-90, 20) font:14 text:nil color:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:_nameLabel];
        _playLabel = [ToolUtil labelwithFrame:CGRectMake(_photoImage.right+10, _nameLabel.bottom+5, _nameLabel.width, _nameLabel.height) font:14 text:nil color:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:_playLabel];
        _rockLabel = [ToolUtil labelwithFrame:CGRectMake(_photoImage.right+10, _playLabel.bottom+5, _nameLabel.width, _nameLabel.height) font:14 text:nil color:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:_rockLabel];
        _timeLabel = [ToolUtil labelwithFrame:CGRectMake(_photoImage.right+10, _rockLabel.bottom+5, _nameLabel.width, _nameLabel.height) font:14 text:nil color:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}/*
  @property (nonatomic ,copy)NSString *avatar;//图片
  @property (nonatomic ,copy,setter = setId:)NSString *myId;
  @property (nonatomic ,copy)NSString *duty;//
  @property (nonatomic ,copy)NSString *name;//影片名字
  @property (nonatomic ,copy)NSString *rt;//上映时间
  @property (nonatomic ,copy)NSString *roles;//扮演角色
  */
-(void)configCellWith:(ActorDetialModel *)model
{
    NSLog(@"%lf---%lf",self.width,self.height);

    [_photoImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    _nameLabel.text = model.name;
    

    _playLabel.text = model.duty;
    
    _rockLabel.text = model.roles;
    
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
