//
//  UIDevice+CP_DisplayDetails.h
//  CPLib
//
//  Created by Chetan Patil on 7/24/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CP_DisplayDetails)

+(BOOL)isiPad;
+(BOOL)isiPhone;
+(BOOL)isStandardDisplay;
+(BOOL)isRetinaDisplay;
+(BOOL)isRetinaiPad;
+(BOOL)isRetinaiPhone;
+(BOOL)isStandardiPad;
+(BOOL)isStandardiPhone;

@end
