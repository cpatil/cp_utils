//
//  NSFileManager+Sorting.m
//  totShot
//
//  Created by Chetan Patil on 11/8/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "NSFileManager+Sorting.h"

@implementation NSFileManager (Sorting)

static NSInteger contentsOfDirSort(NSURL *leftURL, NSURL *rightURL, void *ptr)
{
    (void)ptr;
    
    NSDate * dateLeft ;
    [leftURL getResourceValue:&dateLeft
                       forKey:NSURLContentModificationDateKey
                        error:nil] ;
    
    NSDate * dateRight ;
    [leftURL getResourceValue:&dateRight
                       forKey:NSURLContentModificationDateKey
                        error:nil] ;
    
    return [dateLeft compare:dateRight];
}


- (NSArray *)contentsOrderedByDateOfDirectoryAtPath:(NSURL *)URLOfFolder
{
    NSArray *files = [self contentsOfDirectoryAtURL:URLOfFolder
                         includingPropertiesForKeys:[NSArray arrayWithObject:NSURLContentModificationDateKey]
                                            options:0
                                              error:nil];
    
    return [files sortedArrayUsingFunction:contentsOfDirSort
                                   context:nil] ;
}
@end
