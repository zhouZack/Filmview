//
//  InDetailModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/21.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "InDetailModel.h"

@implementation InDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
@end
