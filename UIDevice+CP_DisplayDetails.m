//
//  UIDevice+CP_DisplayDetails.m
//  CPLib
//
//  Created by Chetan Patil on 7/24/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "UIDevice+CP_DisplayDetails.h"

@implementation UIDevice (CP_DisplayDetails)

// 0 for standard resolution iPhone/iPod touch, 1 for retina iPhone, 2 for standard resolution iPad, 3 for retina iPad.
+(int)encodedDeviceDetails
{
    static int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    return d;
}
+(BOOL)isiPad
{
  return [self encodedDeviceDetails] > 1;
}

+(BOOL)isiPhone
{
    return [self encodedDeviceDetails] < 1;
}

+(BOOL)isStandardDisplay
{
    return ([self encodedDeviceDetails] == 0) || ([self encodedDeviceDetails] == 2);
}

+(BOOL)isRetinaDisplay
{
    return ([self encodedDeviceDetails] == 1) || ([self encodedDeviceDetails] == 3);
}

+(BOOL)isRetinaiPad
{
    return [self encodedDeviceDetails] == 3;
}

+(BOOL)isRetinaiPhone
{
    return [self encodedDeviceDetails] == 1;
}

+(BOOL)isStandardiPad
{
    return [self encodedDeviceDetails] == 2;
}

+(BOOL)isStandardiPhone
{
    return [self encodedDeviceDetails] == 0;
}


@end
