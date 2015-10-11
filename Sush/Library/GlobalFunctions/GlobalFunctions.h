//
//  GlobalFunctions.h
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//


static inline void ShowMessageWithTitle(NSString * const strTitle, NSString * const strMessage)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

static inline void ShowErrorMessage(NSString * const userMessage, NSError* error)
{
    ShowMessageWithTitle(@"Error", userMessage);
    NSLog(@"ERROR: %@", error);
}

@interface GlobalFunctions : NSObject

@end
