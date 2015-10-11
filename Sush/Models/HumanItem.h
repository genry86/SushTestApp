//
//  HumanItem.h
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//


@interface HumanItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDate *birthday;

@end
