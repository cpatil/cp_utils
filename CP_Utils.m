//
//  CP_Utils.m
//  Reference
//
//  Created by Chetan Patil on 8/21/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "CP_Utils.h"

@implementation CP_Utils

+(NSArray *)stableWeightedUniq:(NSArray *)inputArr
{
    NSCountedSet *weightedSet = [[NSCountedSet alloc] initWithArray:inputArr];
    NSArray *sorted = [[NSOrderedSet orderedSetWithArray:inputArr] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        if ([weightedSet countForObject:a] >=
            [weightedSet countForObject:b]) {
            //                NSLog(@"comparing %@ (%d) vs %@(%d) and returning NSOrderedAscending", a, [weightedSet countForObject:a], b, [weightedSet countForObject:b]);
            return (NSComparisonResult)NSOrderedAscending;
        }
        else {
            //                NSLog(@"comparing %@ (%d) vs %@(%d) and returning NSOrderedDescending", a, [weightedSet countForObject:a], b, [weightedSet countForObject:b]);
            return (NSComparisonResult)NSOrderedDescending;
        }
    }];
    
    return sorted;
}

+(NSArray *)splitOnWhiteSpaceCharacterSet:(NSString *)string
{
    return ([[string componentsSeparatedByCharactersInSet:WHITESPACE_CHARACTER_SET] filteredArrayUsingPredicate:DISCARD_EMPTY_STRINGS_PREDICATE]);
}

+(NSString *)documentsPathForFile:(NSString *)name
{
    return [[self documentsDirPath] stringByAppendingPathComponent:name];
}

+ (NSURL*)appDataDirectoryForPath:(NSSearchPathDirectory)nspd {
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:nspd
                                             inDomains:NSUserDomainMask];
    NSURL* appSupportDir = nil;
    NSURL* appDirectory = nil;
    
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    
    // If a valid app support directory exists, add the
    // app's bundle ID to it to specify the final directory.
    if (appSupportDir) {
        NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    return appDirectory;
}

+(NSString *)documentsDirPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    return ([paths objectAtIndex:0]);
//    return [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
//                                                   inDomains:NSUserDomainMask] lastObject] path];
}

+(NSURL *)documentsDirUrl
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //    return ([paths objectAtIndex:0]);
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+(BOOL)fileExistsAtPath:(NSString *)filePath
{
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES);
    //        return ([[NSFileManager defaultManager] isReadableFileAtPath:filePath] == YES);
}

+(NSError *)deleteFileAtPath:(NSURL *)fileURL
{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error];
    return error;
}

+(BOOL)documentsDirHasExistingFile:(NSString *)fileName
{
    return ([self fileExistsAtPath:[self documentsPathForFile:fileName]]);
}

+ (NSDictionary *) attributesForFile:(NSURL *)anURI {
    
    // note: singleton is not thread-safe
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *aPath = [anURI path];
    
    if (![fileManager fileExistsAtPath:aPath]) return nil;
    
    NSError *attributesRetrievalError = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:aPath
                                                             error:&attributesRetrievalError];
    
    if (!attributes) {
        NSLog(@"Error for file at %@: %@", aPath, attributesRetrievalError);
        return nil;
    }
    
    NSMutableDictionary *returnedDictionary =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     [attributes fileType], @"fileType",
     [attributes fileModificationDate], @"fileModificationDate",
     [attributes fileCreationDate], @"fileCreationDate",
     [NSNumber numberWithUnsignedLongLong:[attributes fileSize]], @"fileSize",
     nil];
    
    return returnedDictionary;
}

+(NSURL *)tempDirUrlForFile:(NSString *)fileName
{
    return ([[NSURL alloc] initFileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:fileName]]);
}

+(void)showAlertWithTitle:(NSString *)title
           andWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
    [alertView show];
}


+ (void)showError:(NSError *)error
{
    [self showAlertWithTitle:[NSString stringWithFormat:@"Crash! (%ld)", (long)[error code] ]
              andWithMessage:[error localizedDescription]];
}

+(void)showErrorWithTitle:(NSString *)title
                 andError:(NSError *)error
{
    [self showAlertWithTitle:title
              andWithMessage:[error localizedDescription]];
}

+(NSError *)copyFileAtUrl:(NSURL *) srcUrl
                    toUrl:(NSURL *) destUrl
{
    return ([self copyFileAtPath:[srcUrl path] toPath:[destUrl path]]);
}

+(NSError *)copyFileAtPath:(NSString *) srcPath
                    toPath:(NSString *) destPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *err;
    if ([fm fileExistsAtPath:destPath]) {
        NSDictionary *dict = [fm attributesOfFileSystemForPath:destPath error:&err];
        NSLog(@"dic for (%@):%@",destPath, dict);
        [fm removeItemAtPath:destPath error:nil];
    }
    [fm copyItemAtPath:srcPath toPath:destPath  error:&err];
    return err;
}

+(NSError *)createCustomErrorWithDesc:(NSString *)errorDetailValue
                andCode:(NSInteger)errCode
{
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:errorDetailValue forKey:NSLocalizedDescriptionKey];
    return([NSError errorWithDomain:@"com.cpatil" code:errCode userInfo:errorDetail]);
}

//+ (NSString *) generateUUID {
//	CFUUIDRef uuid = CFUUIDCreate(NULL);
//	CFStringRef str = CFUUIDCreateString(NULL, uuid);
//	CFRelease(uuid);
//	NSString *string = (__bridge NSString *) str;
//	NSMutableString *result = [NSMutableString stringWithString: string];
//	[string autorelease];
//	[result replaceOccurrencesOfString: @"-" withString: @"" options: NSLiteralSearch
//								 range: NSMakeRange(0, [result length]) ];
//	return result;
//}

+ (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *existingFiles = [fileManager contentsOfDirectoryAtPath:folder error:nil];
    NSString *uniqueFilename;
    
    do {
        
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        NSString *newUniqueIdString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        CFRelease(newUniqueId);
        
        uniqueFilename = [[folder stringByAppendingPathComponent:[@"ts_" stringByAppendingString:newUniqueIdString]] stringByAppendingPathExtension:fileExtension];
    } while ([existingFiles containsObject:uniqueFilename]);
    
    return uniqueFilename;
}

+ (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension withPrefix:(NSString *)prefix
{
    NSString *fname = [self getUniqueFilenameInFolder:folder forFileExtension:fileExtension withPrefix:prefix];
    return [prefix stringByAppendingString:fname];
}


+(NSString *)uuid {
    // Returns a UUID
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidStr;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+(NSArray *)findFilesInDocumentsDir:(NSString *)extension
{
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath:[self documentsDirPath] error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            [matches addObject:item];
        }
    }
    return matches;
}

@end
