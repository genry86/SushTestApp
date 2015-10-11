//
//  DownloadDataHelper.h
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//


@interface DownloadDataHelper : NSObject
+ (DownloadDataHelper*)sharedInstance;
- (void)downloadJSON:(NSString*)jsonURL completionBlock:(DownloadDataHCompletionBlock)completionBlock;
- (void)downloadImage:(NSString*)imageURL completionBlock:(DownloadImageHCompletionBlock)completionBlock;

@end
