//
//  HttpRequestHelper.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void(^HttpFailureBlcok) (NSError *error);

@interface HttpRequestHelper : NSObject

/**
 电影首页界面数据请求
 */
+ (void)moveControlRequestSuccess:(HttpSuccessBlock)success1 Failure:(HttpFailureBlcok)failure1;
/**
 待映界面数据请求
 */
+(void)waitShowControlRequestSuccess:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;

/**
 详情界面:内容数据请求
 */
+ (void)detailControlWithContainWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 详情界面:导演数据请求
 */
+ (void)detailControlWithactorWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 详情界面:BoxOffice数据请求
 */
+ (void)detailControlWithBoxOfficeWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;

@end
