//
//  HttpRequestHelper.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "HttpRequestHelper.h"

@implementation HttpRequestHelper

+ (void)moveControlRequestSuccess:(HttpSuccessBlock)success1 Failure:(HttpFailureBlcok)failure1{
    
    [[self createManager] GET:@"http://api.maoyan.com/mmdb/movie/v1/list/hot.json?&ct=%E4%B8%8A%E6%B5%B7" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success1 == nil) return ;
        success1(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure1 == nil) return ;
        failure1(error);
    }];
}
+(void)waitShowControlRequestSuccess:(HttpSuccessBlock)success Failure:(HttpFailureBlcok)failure{
    [[self createManager] GET:@"http://api.maoyan.com/mmdb/movie/v1/list/coming.json?ct=%E4%B8%8A%E6%B5%B7" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
//249141
//http://api.maoyan.com/mmdb/movie/v5/249141.json
//http://api.maoyan.com/mmdb/v6/movie/249141/celebrities.json
//http://api.maoyan.com/mmdb/movie/249141/feature/mbox.json
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


+ (AFHTTPRequestOperationManager *)createManager{
    
    AFHTTPRequestOperationManager *manamger = [AFHTTPRequestOperationManager manager];
    manamger.requestSerializer = [AFJSONRequestSerializer serializer];
    return manamger;
}
@end
