//
//  ToolUtil.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/21.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "ToolUtil.h"

@implementation ToolUtil

+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font BackImage:(NSString*)backImage target:(id)target action:(SEL)action color:(UIColor*)color title:(NSString*)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}
+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font SelectBackImage:(NSString*)selcetBackImage target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:selcetBackImage] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}
+(UIButton *)buttonWithFrame:(CGRect)frame font:(CGFloat)font Image:(NSString*)Image selectImage:(NSString*)selectImage target:(id)target action:(SEL)action color:(UIColor*)color title:(NSString*)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:nil forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}
+(UIButton *)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action color:(UIColor *)color title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}
+(UILabel *)labelWithFont:(CGFloat)font color:(UIColor*)color bold:(BOOL)bold Alignment:(NSTextAlignment)alignment text:(NSString*)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    if (bold == YES) {
        label.font = [UIFont boldSystemFontOfSize:font];
    }else{
        label.font = [UIFont systemFontOfSize:font];
    }
    return label;
}
+(UILabel *)labelWithFrame:(CGRect)frame font:(CGFloat)font color:(UIColor*)color Alignment:(NSTextAlignment)alignment text:(NSString*)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    return label;
}
+(UILabel *)labelwithFrame:(CGRect)frame font:(CGFloat)font text:(NSString*)text color:(UIColor*)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    label.textColor = color;
    return label;
}
+ (UIButton *)buttonWithSize:(CGSize)size title:(NSString *)title selectTitle:(NSString *)selectTitle layer:(BOOL)layer target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    btn.size = size;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:selectTitle forState:UIControlStateSelected];
    if (layer == YES) {
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }

    return btn;
}
+(NSString*)changeImageStringWith:(NSString*)str
{
    NSMutableString*img = [NSMutableString stringWithFormat:@"%@",str];
    [img replaceOccurrencesOfString:@"w" withString:@"200" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 25)];
    [img replaceOccurrencesOfString:@"h" withString:@"280" options:NSCaseInsensitiveSearch range:NSMakeRange(5, 30)];
    return [NSString stringWithFormat:@"%@",img];
}
+ (NSString*)changeDeleteImageStringWith:(NSString*)str
{
    NSMutableString *img = [NSMutableString stringWithFormat:@"%@",str];
    [img replaceOccurrencesOfString:@"/w.h" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, img.length)];
    return [NSString stringWithFormat:@"%@",img];
}
+(UIBarButtonItem*)barButtonWithImage:(NSString*)image frame:(CGRect)frame left:(BOOL)left target:(id)taget action:(SEL)action
{
    UIButton*btn = [[UIButton alloc] initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*barItm = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barItm;
    
    
}
@end
