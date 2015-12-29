//
//  EnterModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterPoModel : NSObject

@property (nonatomic ,copy)NSString *cat;//类别
@property (nonatomic ,copy)NSString *enm;//英文名
@property (nonatomic ,copy)NSString *rt;//上映时间
@property (nonatomic ,copy)NSString *nm;//名字
@property (nonatomic ,copy)NSString *sc;//评分
@property (nonatomic ,copy)NSString *img;
@property (nonatomic ,copy)NSString *myId;
-(instancetype)initWith:(NSDictionary *)dict;

@end
