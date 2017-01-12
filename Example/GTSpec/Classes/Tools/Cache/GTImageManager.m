//
//  DMImageManager.m
//  i8WorkClient
//
//  Created by 郭通 on 16/7/8.
//  Copyright © 2016年 郭通. All rights reserved.
//

#import "GTImageManager.h"
#import "GTPhotoCache.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"

@implementation GTImageManager

+ (void)downImage:(NSString *)aUrl
{
    NSString *urlString = aUrl;
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[GTPhotoCache sharedPhotoCache] imageForKey:urlString]) {
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        // 没缓存图片,下载
        __block BOOL isDownloadCompleted = NO;
        [manager downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            isDownloadCompleted = YES;
            [[GTPhotoCache sharedPhotoCache] storeImage:image forKey:urlString];
        }];
    }
}


@end
