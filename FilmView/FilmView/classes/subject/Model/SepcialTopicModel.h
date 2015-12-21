//
//  SpecialTopicModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SepcialTopicModel : NSObject

@property (nonatomic ,copy)NSString  *myId;
@property (nonatomic ,strong)NSMutableArray   *topicArray;//内容数组
@property (nonatomic ,copy)NSString  *summary;//简介
@property (nonatomic ,copy)NSString  *title;//标题

- (instancetype)initWithDict:(NSDictionary *)dict;

@end



@interface topicMovieModel : NSObject
@property (nonatomic ,copy)NSString  *myId;
@property (nonatomic ,strong)NSArray   *movies;//内容数组
@property (nonatomic ,copy)NSString  *img;//图片
@property (nonatomic ,copy)NSString  *nm;//标题
- (instancetype)initWithDict:(NSDictionary*)dict;


@end