//
//  InformationCell.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationModel.h"
@interface InformationCell : UITableViewCell


-(void)configWithModel:(InformationModel*)model;

@end
