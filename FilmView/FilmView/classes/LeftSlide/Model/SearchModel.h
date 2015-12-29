//
//  SearchModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic ,strong)NSString *cat;
@property (nonatomic ,strong)NSString *nm;
@property (nonatomic ,strong)NSString *img;
@property (nonatomic ,strong)NSNumber *sc;
@property (nonatomic ,strong)NSString *rt;
@property (nonatomic ,strong)NSString *myId;

-(instancetype)initWihDict:(NSDictionary*)dict;
@end
