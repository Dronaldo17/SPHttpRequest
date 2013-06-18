//
//  DRTools.h
//  CometTest
//
//  Created by doujingxuan on 13-6-12.
//  Copyright (c) 2013年 FCNN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DRTools : NSObject
/**Author:Ronaldo Description:从本地NSUserDefaults取出值*/
+(id)getValueFromNSUserDefaultsByKey:(NSString*)key;

/**Author:Ronaldo Description:同步NSUserDefaults数据*/
+(void)syncNSUserDeafaultsByKey:(NSString*)key withValue:(id)value;

/**Author:Ronaldo Description:弹一个提示框*/
+(void)tapAlertWithMessage:(NSString*)message;

/**Author:Ronaldo Description:NSDate转NSString*/
+(NSString*)stringFromADate:(NSDate*)date withFormat:(NSString*)format;

@end
