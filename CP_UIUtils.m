//
//  CP_UIUtils.m
//  CPLib
//
//  Created by Chetan Patil on 7/9/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "CP_UIUtils.h"

@implementation CP_UIUtils

+(CGSize) deviceScreenSize
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    return (CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale));
}

+ (void)beginOrientationSetup
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

+ (BOOL)isLandscapeMode
{
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    UIDeviceOrientation dOrientation = [UIDevice currentDevice].orientation;
    
    bool landscape;
    
    if (dOrientation == UIDeviceOrientationUnknown || dOrientation == UIDeviceOrientationFaceUp || dOrientation == UIDeviceOrientationFaceDown) {
        // If the device is laying down, use the UIInterfaceOrientation based on the status bar.
        landscape = UIInterfaceOrientationIsLandscape(iOrientation);
    } else {
        // If the device is not laying down, use UIDeviceOrientation.
        landscape = UIDeviceOrientationIsLandscape(dOrientation);
        
        // There's a bug in iOS!!!! http://openradar.appspot.com/7216046
        // So values needs to be reversed for landscape!
        if (dOrientation == UIDeviceOrientationLandscapeLeft) iOrientation = UIInterfaceOrientationLandscapeRight;
        else if (dOrientation == UIDeviceOrientationLandscapeRight) iOrientation = UIInterfaceOrientationLandscapeLeft;
        
        else if (dOrientation == UIDeviceOrientationPortrait) iOrientation = UIInterfaceOrientationPortrait;
        else if (dOrientation == UIDeviceOrientationPortraitUpsideDown) iOrientation = UIInterfaceOrientationPortraitUpsideDown;
    }
    
    if (landscape) {
        // Do stuff for landscape mode.
        return YES;
    } else {
        // Do stuff for portrait mode.
        return NO;
    }
    
//    // Now manually rotate the view if needed.
//    switch (iOrientation)
//    {
//        case UIInterfaceOrientationPortraitUpsideDown:
//            [self rotate:180.0f];
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//            [self rotate:90.0f];
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//            [self rotate:-90.0f];
//            break;
//        case UIInterfaceOrientationPortrait:
//            break; //do nothing because it's fine
//        default:
//            break;
//    }
//    
//    // Set the status bar to the right spot just in case
//    [[UIApplication sharedApplication] setStatusBarOrientation:iOrientation];
    
}

+ (BOOL)isPortraitMode
{
    return ![self isLandscapeMode];
}

+(void)scalingPulseView:(UIView*)view toSize: (float) value withDuration:(float) duration
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:value];;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [view.layer addAnimation:pulseAnimation forKey:nil];
}

+(void)opacityPulseLayer:(CALayer *)layer fromOpacity:(float)initialValue toOpacity:(float)value withDuration:(float) duration   andKeyId:(NSString *)animationKeyId
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pulseAnimation.duration = duration;
    pulseAnimation.fromValue = [NSNumber numberWithFloat:initialValue];
    pulseAnimation.toValue = [NSNumber numberWithFloat:value];;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [layer addAnimation:pulseAnimation forKey:animationKeyId];
}

+(void)opacityPulseLayer:(CALayer *)layer toOpacity:(float)value withDuration:(float) duration
{
    [self opacityPulseLayer:layer fromOpacity:1.0 toOpacity:value withDuration:duration andKeyId:nil];
}

+(void)opacityPulseView:(UIView*)view toOpacity:(float)value withDuration:(float) duration
{
    [self opacityPulseLayer:view.layer fromOpacity:1.0 toOpacity:value withDuration:duration andKeyId:nil];
}



@end
