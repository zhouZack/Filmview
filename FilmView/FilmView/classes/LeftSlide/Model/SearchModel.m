//
//  SearchModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(instancetype)initWihDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.myId = [NSString stringWithFormat:@"%ld",[dict[@"id"] integerValue]];
        NSString *img = [ToolUtil changeImageStringWith:dict[@"img"]];
        self.img = img;
    }
    return self;
}
@end
