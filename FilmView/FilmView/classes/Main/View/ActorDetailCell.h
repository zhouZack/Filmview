//
//  ActorDetailCell.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorDetialModel.h"
@interface ActorDetailCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *photoImage;

@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *playLabel;
@property (nonatomic ,strong)UILabel *rockLabel;
@property (nonatomic ,strong)UILabel *timeLabel;

- (void)configCellWith:(ActorDetialModel*)model;

@end
