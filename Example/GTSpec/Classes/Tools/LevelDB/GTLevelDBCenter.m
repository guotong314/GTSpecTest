//
//  GTLevelDBCenter.m
//  GTEmptyView
//
//  Created by 郭通 on 16/9/5.
//  Copyright © 2016年 郭通. All rights reserved.
//

#import "GTLevelDBCenter.h"
#import <Objective-LevelDB/LevelDB.h>
#import "GTPath.h"

#define MLSIM_IM_LEVELDB_VERSATION                 @"1.0.1"
#define MLSIM_IM_LEVELDB_VERSATION_KEY             @"MLSIM_IM_LEVEL_DB_KEY"
#define MLSIM_IM_LEVELDB_NAME                      @"IM.ldb"
#define MLSIM_IM_LEVELDB_DIRECTION                 @"IMLevelDB"

@interface GTLevelDBCenter()

@property (nonatomic, strong)LevelDB *db;

@end

@implementation GTLevelDBCenter

+ (instancetype)shareInstance {
    static GTLevelDBCenter *g_cacheCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_cacheCenter = [[GTLevelDBCenter alloc] init];
    });
    return g_cacheCenter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self checkLevelDBVersation];
    }
    return self;
}
//- (void)cacheObjects:(NSArray <id<MLSIMCacheEntityProtocol>> *)objects {
//    self.db.safe = true;
//    [objects enumerateObjectsUsingBlock:^(id <MLSIMCacheEntityProtocol> obj, NSUInteger idx, BOOL *stop) {
//        [self.db setObject:obj forKey:[obj levelKey]];
//    }];
//    self.db.safe = false;
//    self.db.useCache = false;
//}
//
//- (void)deleteCacheObjects:(NSArray <id<MLSIMCacheEntityProtocol>> *)objects {
//    [objects enumerateObjectsUsingBlock:^(id <MLSIMCacheEntityProtocol> obj, NSUInteger idx, BOOL *stop) {
//        [self.db removeObjectForKey:[obj levelKey]];
//    }];
//}
- (void)cacheObjects:(NSArray <id<GTLevelDBProtocol>> *)objects {
    self.db.safe = true;
    [objects enumerateObjectsUsingBlock:^(id <GTLevelDBProtocol> obj, NSUInteger idx, BOOL *stop) {
        [self.db setObject:obj forKey:[obj levelKey]];
    }];
    self.db.safe = false;
    self.db.useCache = false;
}

- (void)deleteCacheObjects:(NSArray <id<GTLevelDBProtocol>> *)objects {
    [objects enumerateObjectsUsingBlock:^(id <GTLevelDBProtocol> obj, NSUInteger idx, BOOL *stop) {
        [self.db removeObjectForKey:[obj levelKey]];
    }];
}

- (NSArray *)getCacheObjectForKeys:(NSArray<NSString *> *)keys {
    NSMutableArray *cacheObjects = [[NSMutableArray alloc] init];
    [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        id object = [self.db objectForKey:obj];
        if (object) {
            [cacheObjects addObject:object];
        }
    }];
    return cacheObjects;
}

- (NSArray *)getCacheObjectForPredicate:(NSPredicate *)predicate {
    return [[self.db dictionaryByFilteringWithPredicate:predicate] allValues];
}

- (id)getObjectForKey:(NSString *)key {
    id object = [self.db objectForKey:key];
    return object;
}
- (void)storeObject:(id)object forKey:(NSString *)key {
    [self.db setObject:object forKey:key];
}
- (NSArray *)getAllCacheObjectsForPrefixKey:(NSString *)prefixKey {
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    [self.db enumerateKeysAndObjectsUsingBlock:^(LevelDBKey *key, id value, BOOL *stop) {
        NSString *keyString = NSStringFromLevelDBKey(key);
        if ([keyString hasPrefix:prefixKey]) {
            [objects addObject:value];
        }
    }];
    return objects;
}
- (void) removeAllCacheObjectsForPrefixKey:(NSString *)prefixKey
{
    [self.db removeAllObjectsWithPrefix:prefixKey];
}
#pragma mark - Property
- (LevelDB *)db {
    if (!_db) {
        
        _db = [[LevelDB alloc] initWithPath:[self levelDBDirection] name:MLSIM_IM_LEVELDB_NAME andOptions:self.dbOptions];
//        @weakify(self);
        _db.encoder = ^ NSData * (LevelDBKey *key,id object) {
//            @strongify(self);
//            Class<MLSIMCacheEntityProtocol> class = [self.cacheRegister getClassForLevelKey:key];
//            if (class) {
//                return [class encode:object];
//            } else {
                return [NSKeyedArchiver archivedDataWithRootObject:object];
//            }
//            return [GTUser encode:object];
        };
        
        _db.decoder = ^ id (LevelDBKey *key, NSData *data) {
//            @strongify(self);
//            Class<MLSIMCacheEntityProtocol> class = [self.cacheRegister getClassForLevelKey:key];
//            if (class) {
//                id object = [class decodeWithData:data];
//                return object;
//            } else {
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            }
//            return [GTUser decodeWithData:data];
        };
        
        
    }
    return _db;
}

- (LevelDBOptions)dbOptions {
    LevelDBOptions options = [LevelDB makeOptions];
    options.createIfMissing = true;
    options.errorIfExists = false;
    options.paranoidCheck = false;
    options.compression = true;
    options.filterPolicy = 0;
    options.cacheSize = 0;
    return options;
}

- (void)checkLevelDBVersation {
    NSString *currentLevelDBVersation = [[NSUserDefaults standardUserDefaults] valueForKey:MLSIM_IM_LEVELDB_VERSATION_KEY];
    if (![currentLevelDBVersation isEqualToString:MLSIM_IM_LEVELDB_VERSATION]) {
        //levelDB 版本需要升级
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[self levelDBDirection]]) {
            NSError *error;
            [fileManager removeItemAtPath:[self levelDBDirection] error:&error];
            if (!error) {
                [[NSUserDefaults standardUserDefaults] setValue:MLSIM_IM_LEVELDB_VERSATION forKey:MLSIM_IM_LEVELDB_VERSATION_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:MLSIM_IM_LEVELDB_VERSATION forKey:MLSIM_IM_LEVELDB_VERSATION_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (NSString *)levelDBDirection {
    NSString *path = [[GTPath documentPath] stringByAppendingPathComponent:MLSIM_IM_LEVELDB_DIRECTION];
    return path;
}

- (NSString *)levelDBPath {
    NSString *path = [self.levelDBDirection stringByAppendingPathComponent:MLSIM_IM_LEVELDB_NAME];
    return path;
}


@end
