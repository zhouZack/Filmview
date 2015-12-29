//
//  EnterModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "EnterPoModel.h"

@implementation EnterPoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(instancetype)initWith:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSString*imge = [ToolUtil changeImageStringWith:dict[@"img"]];
        self.img = imge;
        self.myId = dict[@"id"];
    }
    return self;
}
@end
