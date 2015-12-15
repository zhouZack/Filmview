//
//  MovieModel.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/11.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(instancetype)initWithDict:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
        
        
        NSMutableString *mbString = [NSMutableString stringWithFormat:@"%@",dictionary[@"img"]];
        [mbString replaceOccurrencesOfString:@"0" withString:@"1" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 10)];
        [mbString replaceOccurrencesOfString:@"w" withString:@"200" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 25)];
        [mbString replaceOccurrencesOfString:@"h" withString:@"280" options:NSCaseInsensitiveSearch range:NSMakeRange(5, 30)];
        self.img = mbString;
        
        NSNumberFormatter *formate = [[NSNumberFormatter alloc] init];
        NSString *myid = [formate stringFromNumber:dictionary[@"id"]];
        self.myId = myid;
        
        
    }
    return self;
}
@end
