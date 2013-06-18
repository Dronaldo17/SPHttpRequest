//
//  Parse.m
//  Parse
//
//  Created by Ronaldo on 13-3-9.
//  Copyright (c) 2013年 FCNN Inc. All rights reserved.
//

#import "Parse.h"
#import "UUMacros.h"

@implementation Parse
+(NSString* ) convertBirthdayToConstellation:(NSDate *) birthday
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MM&dd"];
    NSString *strDate = [dateFormatter stringForObjectValue:birthday];
    NSArray *dateArray = [strDate componentsSeparatedByString:@"&"];
    if(dateArray.count < 2) return nil;
    NSInteger month = [(NSString *) [dateArray objectAtIndex:0] integerValue];
    NSInteger day = [(NSString *) [dateArray objectAtIndex:1] integerValue];
    NSString *strConstellation = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSArray *arrayDate = [NSArray arrayWithObjects:BOX_INT(20), BOX_INT(19), BOX_INT(21), BOX_INT(20), BOX_INT(21), BOX_INT(22), BOX_INT(23),BOX_INT(23), BOX_INT(23), BOX_INT(24), BOX_INT(23), BOX_INT(22),nil];
    NSInteger tempIndex = month * 2  - (day < UNBOX_INT([arrayDate objectAtIndex:(month - 1)])? 2 : 0);
    NSString *result = [strConstellation substringWithRange:NSMakeRange((NSUInteger )tempIndex, 2)];
    return result;
}

@end
