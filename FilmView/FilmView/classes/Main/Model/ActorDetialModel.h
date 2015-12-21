//
//  ActorDetialModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorDetialModel : NSObject

@property (nonatomic ,copy)NSString *avatar;//图片
@property (nonatomic ,copy,setter = setId:)NSString *myId;
@property (nonatomic ,copy)NSString *duty;//
@property (nonatomic ,copy)NSString *name;//影片名字
@property (nonatomic ,copy)NSString *rt;//上映时间
@property (nonatomic ,copy)NSString *roles;//扮演角色

-(instancetype)initWith:(NSDictionary*)dict;
/*
 avatar	:	http://p0.meituan.net/w.h/movie/29e6f291dc52a7d4ba9f384fa0134dd8114173.jpg
 
 cr	:	1
 
 duty	:	演员
 
 globalReleased	:	false
 
 id	:	338493
 
 name	:	南极绝恋
 
 roles	:
 
 rt	:	2017
 
 sc	:	0
 
 wish	:	601

 
 */
@end
