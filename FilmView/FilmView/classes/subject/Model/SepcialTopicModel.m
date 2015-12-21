//
//  SpecialTopicModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SepcialTopicModel.h"

@implementation SepcialTopicModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSNumberFormatter*fam = [[NSNumberFormatter alloc] init];
        self.myId = [fam stringFromNumber:dict[@"id"]];
        
    }
    return self;
}
@end

@implementation topicMovieModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSNumberFormatter*fam = [[NSNumberFormatter alloc] init];
        self.myId = [fam stringFromNumber:dict[@"id"]];
        self.img = [ToolUtil changeImageStringWith:dict[@"img"]];
        
    }
    return self;
}

@end