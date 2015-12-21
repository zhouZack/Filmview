//
//  InformationModel.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject

@property (nonatomic ,copy)NSString  *title;
@property (nonatomic ,copy)NSString  *myId;
@property (nonatomic ,strong)NSArray *images;
@property (nonatomic ,copy)NSString  *url;


-(instancetype)initWithDict:(NSDictionary*)dict;

@end
