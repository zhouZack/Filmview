//
//  CollectItem+CoreDataProperties.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CollectItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *myId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *image;

@end

NS_ASSUME_NONNULL_END
