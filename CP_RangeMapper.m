//
//  CP_RangeMapper.m
//  SoundCamera
//
//  Created by Chetan Patil on 9/27/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "CP_RangeMapper.h"

@interface CP_RangeMapper ()
{
    double scaleFactor;
}

@end

@implementation CP_RangeMapper

- (id)initWithFromMin:(NSNumber *)fromMin
           andFromMax:(NSNumber *)fromMax
             mapToMin:(NSNumber *)toMin
             andToMax:(NSNumber *)toMax
{
    self = [super init];
    if (self != nil) {
        [self setFromMin:fromMin];
        [self setFromMax:fromMax];
        [self setToMin:toMin];
        [self setToMax:toMax];

        scaleFactor = ([toMax doubleValue] - [toMin doubleValue]) / ([fromMax doubleValue] - [fromMin doubleValue]);
    }
    return self;
}

- (NSNumber *)map:(NSNumber *)value
{
    return [[NSNumber alloc] initWithDouble:([[self toMin] doubleValue] + ([value doubleValue] - [[self fromMin] doubleValue]) * scaleFactor)];
}

@end
