//
//  UIImage+Scale.h
//  SoundCamera
//
//  Created by Chetan Patil on 9/27/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
@end
