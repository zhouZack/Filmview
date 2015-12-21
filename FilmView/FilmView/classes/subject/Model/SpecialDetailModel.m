//
//  SpecialDetailModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "SpecialDetailModel.h"

@implementation SpecialDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        if (dict[@"id"]!=nil) {
            NSNumberFormatter*form = [[NSNumberFormatter alloc] init];
            self.myId = [form stringFromNumber:dict[@"id"]];
        }
        if (dict[@"img"]!=nil) {
            NSString *img = [ToolUtil changeImageStringWith:dict[@"img"]];
            self.img = img;
        }
    }
    return self;
}
@end
