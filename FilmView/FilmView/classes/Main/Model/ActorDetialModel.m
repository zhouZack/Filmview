//
//  ActorDetialModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ActorDetialModel.h"

@implementation ActorDetialModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
-(instancetype)initWith:(NSDictionary*)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSString*img = [ToolUtil changeImageStringWith:dict[@"avatar"]];
        NSNumberFormatter *forma = [[NSNumberFormatter alloc] init];
        self.myId = [forma stringFromNumber:dict[@"id"]];
        
        self.avatar  = img;
    }
    return self;
}
@end
