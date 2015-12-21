//
//  InDetailModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/21.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InDetailModel : NSObject
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *text;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
