//
//  SpecialDetailModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialDetailModel : NSObject

@property (nonatomic ,copy)NSString  *myId;
@property (nonatomic ,copy)NSString  *nm;//名字
@property (nonatomic ,copy)NSString  *cat;//类别
@property (nonatomic ,copy)NSString  *star;//演员
@property (nonatomic ,copy)NSString  *rt;//时间
@property (nonatomic ,copy)NSString  *sc;//评分
@property (nonatomic ,copy)NSString  *img;//图片

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
