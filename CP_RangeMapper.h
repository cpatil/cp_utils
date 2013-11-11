//
//  CP_RangeMapper.h
//  SoundCamera
//
//  Created by Chetan Patil on 9/27/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CP_RangeMapper : NSObject

@property (nonatomic, strong) NSNumber *fromMin;
@property (nonatomic, strong) NSNumber *fromMax;
@property (nonatomic, strong) NSNumber *toMin;
@property (nonatomic, strong) NSNumber *toMax;

- (id)initWithFromMin:(NSNumber *)fromMin
           andFromMax:(NSNumber *)fromMax
             mapToMin:(NSNumber *)toMin
             andToMax:(NSNumber *)toMax;

- (NSNumber *)map:(NSNumber *)value;

@end
