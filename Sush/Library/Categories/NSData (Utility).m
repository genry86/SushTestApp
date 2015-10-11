//
//  NSData (Utility).m
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//

#import "NSData (Utility).h"


@implementation NSData (Utility)

-(ImageType)contentTypeForImageData {
    uint8_t c;
    [self getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return ImageTypeJPEG;
        case 0x89:
            return ImageTypePNG;
        case 0x47:
            return ImageTypeGIF;
        case 0x49:
        case 0x4D:
            return ImageTypeTIFF;
    }
    return ImageTypeUndefined;
}

@end
