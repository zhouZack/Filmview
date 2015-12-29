//
//  WaitshowControl.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitshowControl : UIControl

@property (nonatomic ,copy)void(^block)(NSString*);

@end
