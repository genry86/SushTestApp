//
//  GlobalConstants.h
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//


typedef enum AppMode{
    ImageTypeUndefined = 0,
    ImageTypePNG,
    ImageTypeJPEG,
    ImageTypeGIF,
    ImageTypeTIFF
}ImageType;

extern NSUInteger const kTableViewCellHeight;

extern NSUInteger const kHTTPStatusCodeOK;

extern NSString *const kJSONDataULRAddress;
extern NSString *const kJSONDataItemPeopleField;
extern NSString *const kJSONDataItemNameField;
extern NSString *const kJSONDataItemTitleField;
extern NSString *const kJSONDataItemImageField;
extern NSString *const kJSONDataItemBirthdayField;

typedef void(^DownloadDataHCompletionBlock)(NSArray* pepaleItems);
typedef void(^DownloadImageHCompletionBlock)(NSData *imageData);


@interface GlobalConstants : NSObject

@end
