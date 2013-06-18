/*
 *  DebugLog.h
 *  DebugLog
 *
 *  Created by Karl Kraft on 3/22/09.
 *  Copyright 2009 Karl Kraft. All rights reserved.
 *
 */



#ifdef DEBUG
#define FCNNDEBUG(args...) __apiDebug__(__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#define FCNNWARN(args...) __apiWarn__(__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#define FCNNINFO(args...) __apiInfo__(__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#define FCNNERROR(args...) __apiError__(__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#else
#define FCNNDEBUG(args...) 
#define FCNNWARN(args...)
#define FCNNINFO(args...)
#define FCNNERROR(args...)
#endif

void __apiDebug__(const char *file, int lineNumber,NSString *format,...);
void __apiWarn__(const char *file, int lineNumber,NSString *format,...);
void __apiInfo__(const char *file, int lineNumber,NSString *format,...);
void __apiError__(const char *file, int lineNumber,NSString *format,...);
