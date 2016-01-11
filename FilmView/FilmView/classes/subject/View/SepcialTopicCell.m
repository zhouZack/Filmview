//
//  SepcialTopicCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SepcialTopicCell.h"
@interface SepcialTopicCell ()

@property (nonatomic ,strong)UILabel       *titleLable;
@property (nonatomic ,strong)UILabel       *abstractLabel;
@property (nonatomic ,strong)UIScrollView  *scrollView;
@property (nonatomic ,strong)NSArray       *imageDataArray;


@end

@implementation SepcialTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLable = [ToolUtil labelWithFont:15 color:[UIColor blackColor] bold:YES Alignment:NSTextAlignmentCenter text:nil];
        _titleLable.size = CGSizeMake(UIScreenWidth-20, 30);
        _titleLable.left = 10;
        _titleLable.top = 5;
        [self.contentView addSubview:_titleLable];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, _titleLable.bottom+5, UIScreenWidth-20, 140)];
        [self.contentView addSubview:_scrollView];
        _abstractLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollView.bottom+5, _scrollView.width, 50)];
        _abstractLabel.numberOfLines = 2;
        [self.contentView addSubview:_abstractLabel];
        
    }
    
    return self;
}

- (void)config:(SepcialTopicModel*)model
{
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    _titleLable.text = model.title;
    _abstractLabel.attributedText = [[NSAttributedString alloc] initWithString:model.summary attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.54 alpha:1]}];;
    _abstractLabel.numberOfLines = 2;
    CGFloat width = 90;;
    CGFloat height = 120;
    for (int i = 0; i<model.topicArray.count; i++) {
        topicMovieModel*topicModel = model.topicArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width+5), 0, width, height)];
        imageView.tag = [topicModel.myId integerValue]+10;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
        imageView.userInteractionEnabled =YES;
        [imageView addGestureRecognizer:tapGesture];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        imageView.layer.cornerRadius = 15;
        imageView.clipsToBounds = YES;
        UILabel* label = [ToolUtil labelWithFrame:CGRectMake(imageView.left, imageView.bottom+5, width, 20) font:13 color:[UIColor colorWithWhite:0.4 alpha:1] Alignment:NSTextAlignmentCenter text:topicModel.nm];
        [_scrollView addSubview:imageView];
        [_scrollView addSubview:label];
        UIButton *button = [[UIButton alloc] initWithFrame:imageView.frame];
        button.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
        
    }
    _scrollView.contentSize = CGSizeMake(model.topicArray.count*(width+5), 0);
}
- (void)gestureClick:(UITapGestureRecognizer*)tap
{
    NSLog(@"%ld",tap.view.tag-10);
    NSString *string = [NSString stringWithFormat:@"%ld",tap.view.tag-10];
    if (self.block) {
        self.block(string);
        
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
