//
//  MovieCell.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/12.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thumbImageView;

- (void)configComingCell:(MovieModel *)item;
- (void)configCell:(MovieModel *)item;

@end
