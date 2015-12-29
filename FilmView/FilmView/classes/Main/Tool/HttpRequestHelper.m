//
//  HttpRequestHelper.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "HttpRequestHelper.h"

@implementation HttpRequestHelper
/**
 电影首页界面数据请求
 */
+ (void)moveControlRequestSuccess:(HttpSuccessBlock)success1 Failure:(HttpFailureBlcok)failure1{
    
    [[self createManager] GET:@"http://api.maoyan.com/mmdb/movie/v1/list/hot.json?&ct=%E4%B8%8A%E6%B5%B7" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success1 == nil) return ;
        success1(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure1 == nil) return ;
        failure1(error);
    }];
}
/**
 待映界面数据请求
 */
+(void)waitShowControlRequestSuccess:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure{
    [[self createManager] GET:@"http://api.maoyan.com/mmdb/movie/v1/list/coming.json?ct=%E4%B8%8A%E6%B5%B7" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
/**
 详情界面:内容数据请求
 */
//249141
//http://api.maoyan.com/mmdb/movie/v5/247300.json
//http://api.maoyan.com/mmdb/v6/movie/249141/celebrities.json
//http://api.maoyan.com/mmdb/movie/78701/feature/mbox.json
+ (void)detailControlWithContainWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/%@.json",dID];
    
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
/**
 详情界面:导演数据请求
 */
+ (void)detailControlWithactorWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/movie/%@/celebrities.json",dID];
    
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];

}
/**
 详情界面:BoxOffice数据请求
 */
+ (void)detailControlWithBoxOfficeWithId:(NSString*)dID success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/%@/feature/mbox.json",dID];
    
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];

}
/**
 演员详情界面:演员信息
 */
+ (void)actorDetailControlWithAbstractId:(NSString *)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/celebrity/%@.json",myId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
/**
 演员详情界面:演过的电影信息
 */

+ (void)actorDetailControlWithWorkId:(NSString *)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/celebrity/%@/movies.json?limit=100&offset=0",myId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
/**
 专题界面数据
 */
//http://api.maoyan.com/mmdb/movieboard/list.json?ci=10&limit=10&offset=0
+ (void)specialTopicControlWithInteger:(NSInteger)integer success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movieboard/list.json?ci=10&limit=10&offset=%ld",integer];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
/**
 专题详情界面数据
 */
//http://api.maoyan.com/mmdb/movieboard/440.json
+ (void)specialDetailControlWithMyId:(NSString*)myId success:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movieboard/%@.json",myId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
/**
 影讯界面数据
 */
+(void)informationControlWithInteger:(NSInteger)integer success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/sns/v1/feed.json?__vhost=api.maoyan.com&limit=10&offset=%ld",integer];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
/**
 影讯详情界面
 */
+ (void)informationDetailWithMyId:(NSString*)myId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/sns/news/%@.json?__vhost=api.maoyan.com",myId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}

//片库界面数据
+(void)enterPortDetailWithParameter1:(NSString*)parameter1 Parameter2:(NSString*)parameter2 Parameter3:(NSInteger)parameter3 MyId:(NSInteger)MyId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/search/movie/%@/list.json?%@=%ld&limit=20&offset=%ld",parameter1,parameter2,parameter3,MyId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}

//搜索界面数据请求
+(void)searchControlWithName:(NSString*)name success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/search/movie/keyword/list.json?&keyword=%@",name];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];

}
/**
 图片界面数据请求246581
 */
+(void)photoControlWithMyId:(NSString*)myId success:(HttpSuccessBlock)success failure:(HttpFailureBlcok)failure
{
    NSString *str = [NSString stringWithFormat:@"http://api.maoyan.com/dianying/movie/%@/photos.json",myId];
    [[self createManager] GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success ==nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure ==nil) return ;
        failure(error);
    }];
}
+ (AFHTTPRequestOperationManager *)createManager{
    
    AFHTTPRequestOperationManager *manamger = [AFHTTPRequestOperationManager manager];
    manamger.requestSerializer = [AFJSONRequestSerializer serializer];
    return manamger;
}
@end
