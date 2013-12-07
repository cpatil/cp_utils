//
//  CP_Utils.h
//  Reference
//
//  Created by Chetan Patil on 8/21/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WHITESPACE_CHARACTER_SET [NSCharacterSet whitespaceCharacterSet]
#define DISCARD_EMPTY_STRINGS_PREDICATE [NSPredicate predicateWithFormat:@"SELF != ''"]


@interface CP_Utils : NSObject
{
    
}

+(NSString *)uuid;

// takes in a array with elements multiply  
+(NSArray *)stableWeightedUniq:(NSArray *)inputArr;
+(NSArray *)splitOnWhiteSpaceCharacterSet:(NSString *)string;

+(NSString *)documentsPathForFile:(NSString *)name;
+(NSString *)documentsDirPath;
+(NSURL *)documentsDirUrl;
+ (NSDictionary *)attributesForFile:(NSURL *)anURI;
+ (NSURL*)appDataDirectoryForPath:(NSSearchPathDirectory)nspd;

+(NSURL *)tempDirUrlForFile:(NSString *)fileName;

+(BOOL)documentsDirHasExistingFile:(NSString *)fileName;
+(BOOL)fileExistsAtPath:(NSString *)filePath;
+ (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension;
+ (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension withPrefix:(NSString *)prefix;
+(NSError *)deleteFileAtPath:(NSURL *)fileURL;


+(void)showAlertWithTitle:(NSString *)title
           andWithMessage:(NSString *)message;
+(void)showErrorWithTitle:(NSString *)title
           andError:(NSError *)error;
+ (void)showError:(NSError *)error;

+(NSError *)copyFileAtUrl:(NSURL *) srcUrl
               toUrl:(NSURL *) destUrl;
+(NSError *)copyFileAtPath:(NSString *) srcPath
               toPath:(NSString *) destPath;

+(NSError *)createCustomErrorWithDesc:(NSString *)errorDetailValue
                              andCode:(NSInteger)errCode;

+(NSArray *)findFilesInDocumentsDir:(NSString *)ext;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
@end
