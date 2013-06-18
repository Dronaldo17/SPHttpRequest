/*
 *  DebugLog.m
 *  DebugLog
 *
 *  Created by Karl Kraft on 3/22/09.
 *  Copyright 2009 Karl Kraft. All rights reserved.
 *
 */

#import "ApiLogger.h"


void __apiLog__(const char *file, int lineNumber,NSString *format,...)
{
    va_list ap;

    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
    va_end (ap);
    NSString *fileName=[[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr,"%s:line %d ==> %s",[fileName UTF8String],lineNumber,[body UTF8String]);
    [body release];
}

void __apiDebug__(const char *file, int lineNumber,NSString *format,...)
{
    // check level to determine whether we need to log message
    if (apiGetLogLevel() < ApiLogDebug) {
        return;
    }
    __apiLog__(file, lineNumber, format);
}

void __apiWarn__(const char *file, int lineNumber,NSString *format,...)
{
    if(apiGetLogLevel() < ApiLogWarn)
        return;
    __apiLog__(file, lineNumber, format);
}
void __apiInfo__(const char *file, int lineNumber,NSString *format,...)
{
    if (apiGetLogLevel() < ApiLogInfo)
        return;
    __apiLog__(file, lineNumber, format);
}
void __apiError__(const char *file, int lineNumber,NSString *format,...)
{
    if (apiGetLogLevel() < ApiLogError)
        return;
    __apiLog__(file, lineNumber, format);
}

