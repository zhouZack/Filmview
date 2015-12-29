//
//  PhotoCell.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/25.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
{
    UIImageView *_imageViewc;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageViewc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageViewc];
        
    }
    return self;
}
- (void)config:(NSDictionary *)dict{
    
    [_imageViewc sd_setImageWithURL:[NSURL URLWithString:[ToolUtil changeImageStringWith:dict[@"tlink"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
}

@end
