//
//  CP_UIUtils.h
//  CPLib
//
//  Created by Chetan Patil on 7/9/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CP_UIUtils : NSObject
{}

+ (CGSize)deviceScreenSize;
+ (void)beginOrientationSetup;
+ (BOOL)isLandscapeMode;
+ (BOOL)isPortraitMode;
+(void)scalingPulseView:(UIView*)view toSize: (float) value withDuration:(float) duration;
+(void)opacityPulseLayer:(CALayer *)layer fromOpacity:(float)initialValue toOpacity:(float)value withDuration:(float) duration andKeyId:(NSString *)animationKeyId;
+(void)opacityPulseLayer:(CALayer *)layer toOpacity:(float)value withDuration:(float) duration;
+(void)opacityPulseView:(UIView*)view toOpacity:(float)value withDuration:(float) duration;
@end
