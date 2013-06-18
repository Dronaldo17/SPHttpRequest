//
//  DRTools.m
//  CometTest
//
//  Created by doujingxuan on 13-6-12.
//  Copyright (c) 2013年 FCNN Inc. All rights reserved.
//

#import "DRTools.h"
//#import "ASIHttpRequest.h"

@implementation DRTools
+(id)getValueFromNSUserDefaultsByKey:(NSString*)key
{
    if (key) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        id obj = [defaults objectForKey:key];
        return obj;
    }
    return nil;
}
+(void)syncNSUserDeafaultsByKey:(NSString*)key withValue:(id)value
{
    if (key && value) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:value forKey:key];
        [defaults  synchronize];
    }
}
+(void)tapAlertWithMessage:(NSString*)message
{
//    [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
}
+(NSString*)stringFromADate:(NSDate*)date withFormat:(NSString*)format;
{
    if (isNull(date) || isEmpty(format)) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    return strDate;
}
//+(NSString*)parseHttpError:(NSError*)error
//{
//    NSString * message = nil;
//    switch ([error code])
//    {
//        case ASIRequestTimedOutErrorType:
//            message = @"链接超时";
//            break;
//        case ASIConnectionFailureErrorType:
//            message = @"连接失败";
//            break;
//        case ASIAuthenticationErrorType:
//            message = @"kAlertMsgAuthFailError";
//            break;
//        case ASITooMuchRedirectionErrorType:
//            message = @"kAlertMsgTooManyRedirect";
//            break;
//        case ASIRequestCancelledErrorType:
//            message = @"kAlertMsgReqCancelledError";
//            break;
//        case ASIUnableToCreateRequestErrorType:
//            message = @"kAlertMsgUnableCreateReqError";
//            break;
//        case ASIInternalErrorWhileBuildingRequestType:
//            message = @"kAlertMsgUnableBuildReqError";
//            break;
//        case ASIInternalErrorWhileApplyingCredentialsType:
//            message = @"kAlertMsgUnableApplyCredError";
//            break;
//        case ASIFileManagementError:
//            message = @"kAlertMsgFileManageError";
//            break;
//        case ASIUnhandledExceptionError:
//            message = @"kAlertMsgUnhandledExcepError";
//            break;
//        case ASICompressionError:
//            message = @"kAlertMsgCompressionError";
//            break;
//        default:
//            message = @"kAlertMsgGenericError";
//            break;
//    }
//    return message;
//}
@end
