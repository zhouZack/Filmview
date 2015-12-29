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
/**
 演员详情界面:演员信息
 */
+ (void)actorDetailControlWithAbstractId:(NSString *)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 演员详情界面:演过的电影信息
 */
+ (void)actorDetailControlWithWorkId:(NSString *)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 专题界面数据
 */
+ (void)specialTopicControlWithInteger:(NSInteger)integer success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 专题详情界面数据
 */
+ (void)specialDetailControlWithMyId:(NSString*)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure;
/**
 影讯界面数据
 */
+(void)informationControlWithInteger:(NSInteger)integer success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure;
/**
 影讯详情界面
 */
+ (void)informationDetailWithMyId:(NSString*)myId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure;

/**
 片库界面数据
 */
+(void)enterPortDetailWithParameter1:(NSString*)parameter1 Parameter2:(NSString*)parameter2 Parameter3:(NSInteger)parameter3 MyId:(NSInteger)MyId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure;
/**
 搜索界面数据请求
 http://api.maoyan.com/mmdb/search/movie/keyword/list.json?&keyword=%@
 */
+(void)searchControlWithName:(NSString*)name success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure;
/**
 图片界面数据请求
 */
+(void)photoControlWithMyId:(NSString*)myId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure;







@end
