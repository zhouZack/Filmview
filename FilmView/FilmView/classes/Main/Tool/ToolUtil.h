//
//  ToolUtil.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/21.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ToolUtil : NSObject

+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font BackImage:(NSString*)backImage target:(id)target action:(SEL)action color:(UIColor*)color title:(NSString*)title;
+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font SelectBackImage:(NSString*)selcetBackImage target:(id)target action:(SEL)action;

+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font Image:(NSString*)Image selectImage:(NSString*)selectImage target:(id)target action:(SEL)action color:(UIColor*)color title:(NSString*)title;

+(UIButton *)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action color:(UIColor *)color title:(NSString *)title;

+(UILabel *)labelWithFont:(CGFloat)font color:(UIColor*)color bold:(BOOL)bold Alignment:(NSTextAlignment)alignment text:(NSString*)text;

+(UILabel *)labelWithFrame:(CGRect)frame font:(CGFloat)font color:(UIColor*)color Alignment:(NSTextAlignment)alignment text:(NSString*)text;

//自定义label
+(UILabel *)labelwithFrame:(CGRect)frame font:(CGFloat)font text:(NSString*)text color:(UIColor*)color;

+ (UIButton *)buttonWithSize:(CGSize)size title:(NSString *)title selectTitle:(NSString *)selectTitle layer:(BOOL)layer target:(id)target action:(SEL)action;
//定义UIBarBUtton
+(UIBarButtonItem*)barButtonWithImage:(NSString*)image frame:(CGRect)frame left:(BOOL)left target:(id)taget action:(SEL)action;
//图片转换
+(NSString*)changeImageStringWith:(NSString*)str;
+ (NSString*)changeDeleteImageStringWith:(NSString*)str;
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize;
@end
