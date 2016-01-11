//
//  DetailViewController.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/14.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "MovieModel.h"
@interface DetailViewController : BaseViewController

@property (nonatomic ,strong)MovieModel *moedel;
@property (nonatomic ,strong)NSString *myId;
@property (nonatomic ,copy)NSString *imageViewName;
@property (nonatomic ,assign)BOOL  status;
@end
