//
//  SepcialTopicCell.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SepcialTopicModel.h"
@interface SepcialTopicCell : UITableViewCell


@property (nonatomic ,copy)void(^block)(NSString*);

- (void)config:(SepcialTopicModel*)model;


@end
