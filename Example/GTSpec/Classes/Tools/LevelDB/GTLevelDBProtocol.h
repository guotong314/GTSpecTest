//
//  GTLevelDBProtocol.h
//  GTEmptyView
//
//  Created by 郭通 on 16/9/5.
//  Copyright © 2016年 郭通. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GTLevelDBProtocol <NSObject>

+ (NSString *)cachePrefix;

- (NSString *)levelKey;

@end
