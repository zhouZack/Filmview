//
//  InformationModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "InformationModel.h"

@implementation InformationModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
