//
//  FilmCoreDateHelper.m
//  FilmView
//
//  Created by Zc_zhou on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "FilmCoreDateHelper.h"
#import "CollectItem.h"
@implementation FilmCoreDateHelper
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestCoreDate2" withExtension:@"momd"];
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_coreDataName withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    //    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestCoreDate2.sqlite"];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",_coreDataName]];
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

+(instancetype)share{
    static FilmCoreDateHelper *shareObject;
    static dispatch_once_t one;
    dispatch_once(&one,^{
        shareObject = [[FilmCoreDateHelper alloc] init];
    });
    return shareObject;
}
- (void)insertCoreData:(NSMutableDictionary*)dict
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    CollectItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"CollectItem" inManagedObjectContext:context];
    item.name = dict[@"name"];
    item.image = dict[@"image"];
    item.myId = dict[@"myId"];
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
- (NSArray*)selectData:(int)pageSize andOffset:(int)currentPage
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}
- (void)deleteDataWith:(NSString*)string
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectItem" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (CollectItem *obj in datas)
        {
            if ([obj.myId isEqualToString:string]) {
                [context deleteObject:obj];
            }
            
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}
- (BOOL)searchDataWith:(NSString*)string
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectItem" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    BOOL consequence;
    if (!error && fetchedObjects && [fetchedObjects count])
    {
        for (CollectItem *obj in fetchedObjects)
        {
            if ([obj.myId isEqualToString:string]) {
                consequence = YES;
            }
            
        }

    }
    return  consequence;
    
}

//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook
{
    
}

















@end
