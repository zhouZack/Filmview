//
//  BaseViewController.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


- (void)addtitleWithName:(NSString *)name;

- (void)addUIbarButtonItemWithImage:(NSString*)image left:(BOOL)left frame:(CGRect)frame target:(id)target action:(SEL)action;

- (void)addUIbarButtonItemWithName:(NSString *)name left:(BOOL)left frame:(CGRect)frame target:(id)target action:(SEL)action;
- (void)changeLeftList;

@end
