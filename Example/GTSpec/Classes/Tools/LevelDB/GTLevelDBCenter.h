//
//  GTLevelDBCenter.h
//  GTEmptyView
//
//  Created by 郭通 on 16/9/5.
//  Copyright © 2016年 郭通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLevelDBDataType.h"
#import "GTLevelDBProtocol.h"
@interface GTLevelDBCenter : NSObject
+ (instancetype)shareInstance;

- (void)cacheObjects:(NSArray <id<GTLevelDBProtocol>> *)objects;

- (void)deleteCacheObjects:(NSArray <id<GTLevelDBProtocol>> *)objects;

- (NSArray *)getCacheObjectForKeys:(NSArray<NSString *> *)keys;

- (NSArray *)getCacheObjectForPredicate:(NSPredicate *)predicate;

- (id)getObjectForKey:(NSString *)key;
- (void)storeObject:(id)object forKey:(NSString *)key;

- (NSArray *)getAllCacheObjectsForPrefixKey:(NSString *)prefixKey;
- (void) removeAllCacheObjectsForPrefixKey:(NSString *)prefixKey;
@end
