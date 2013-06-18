//
//  HSMessageObserver.h
//  common
//
//  Created by Ronaldo on 5/23/12.
//  Copyright (c) 2012 Tsinghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IHSMessageObserver.h"

/*************************************
 *
 *  delegate method signature
 *
 ***/

@interface HSMessageObserver : NSObject {
    
@private
    // Dict<Message, NSMutableArray<Entry> >
    NSMutableDictionary* _messageDict;
}

+ (void) doInit;
+ (void) doDestory;
+ (HSMessageObserver*) defaultObserver;

- (BOOL) registerMessage:(NSString*) message receiver:(id<IHSMessageObserver>) receiver;
- (BOOL) unRegisterMessage:(NSString*) message receiver:(id<IHSMessageObserver>) receiver;

- (void) sendMessage:(NSString*) message paramObject:(id) paramObject paramLong:(long) paramLong;

@end
