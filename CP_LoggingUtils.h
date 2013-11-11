//
//  CP_LoggingUtils.h
//  CPLib
//
//  Created by Chetan Patil on 8/19/13.
//  Copyright (c) 2013 Chetan Patil. All rights reserved.
//

#import "LoggerClient.h"

/////////////
// logging
////////////

#ifdef DEBUG
#define NSLog(...)                 LogMessageF(__FILE__,__LINE__,__FUNCTION__,nil, 0,__VA_ARGS__)
#define LOG_NETWORK(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"network",level,__VA_ARGS__)
#define LOG_GENERAL(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"general",level,__VA_ARGS__)
#define LOG_GRAPHICS(level, ...)   LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"graphics",level,__VA_ARGS__)
#define LOG_PDF(level, ...)        LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"pdf",level,__VA_ARGS__)
#define LOG_SEARCH(level, ...)     LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"search",level,__VA_ARGS__)
#else
#define LOG_NETWORK(...)    do{}while(0)
#define LOG_GENERAL(...)    do{}while(0)
#define LOG_GRAPHICS(...)   do{}while(0)
#define LOG_PDF(...)        do{}while(0)
#define LOG_SEARCH(...)     do{}while(0)
#endif

#define AppDelegate (void *)[[UIApplication sharedApplication] delegate]

@interface CP_LoggingUtils : NSObject

@end
