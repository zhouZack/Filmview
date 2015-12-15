//
//  FVGlobal.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/6.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIView+Utils.h"
#import "ToolUtil.h"
#import "HttpRequestHelper.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define IOSVersion(_version) ([[[UIDevice currentDevice] systemVersion] doubleValue] >= _version)
#define UIScreenWidth [[UIScreen mainScreen] bounds].size.width
#define UIScreenHeight [[UIScreen mainScreen] bounds].size.height
//叶显进 352129195406090011

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@interface FVGlobal : NSObject

@end
