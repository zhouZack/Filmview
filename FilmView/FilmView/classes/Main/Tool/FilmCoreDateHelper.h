//
//  FilmCoreDateHelper.h
//  FilmView
//
//  Created by Zc_zhou on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface FilmCoreDateHelper : NSObject
@property (nonatomic, strong) NSString *coreDataName;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+(instancetype)share;


- (void)logNm;
//插入数据
- (void)insertCoreData:(NSMutableDictionary*)dict;
//查询
- (NSArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteDataWith:(NSString*)string;
//查询单个数据
- (BOOL)searchDataWith:(NSString*)string;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
