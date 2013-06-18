//
//  HSMessageObserver.m
//  common
//
//  Created by Ronaldo on 5/23/12.
//  Copyright (c) 2012 Tsinghua. All rights reserved.
//

#import "HSMessageObserver.h"

#import "common.h"
#import "ApiLogger.h"

@interface ObserverEntry : NSObject {
@private
    id<IHSMessageObserver> _delegate;
}

@property(nonatomic, assign) id delegate;
@end

@implementation ObserverEntry

@synthesize delegate = _delegate;

@end


/***************  Observer Implementation ***************/

static HSMessageObserver* _hsMessageObserver = nil;

@implementation HSMessageObserver

+ (void) doInit {
    // make it alloc memory
    [HSMessageObserver defaultObserver];
}

+ (void) doDestory {
    [_hsMessageObserver release];
    _hsMessageObserver = nil;
}

+ (HSMessageObserver*) defaultObserver {
    if (nil == _hsMessageObserver) {
        _hsMessageObserver = [[HSMessageObserver alloc] init];
    }
    return _hsMessageObserver;
}

- (void) dealloc {
    [_messageDict release];
    [super dealloc];
}

- (id) init {
    self = [super init];
    if (self) {
        _messageDict = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return self;
}

- (BOOL) registerMessage:(NSString*) message receiver:(id<IHSMessageObserver>) receiver {
    
    NSMutableArray* entryArray = [_messageDict objectForKey:message];
    
    if (isNull(entryArray)) {
        // there is no entry, we should create a new one
        entryArray = [[[NSMutableArray alloc] initWithCapacity:1] autorelease];
        [_messageDict setObject:entryArray forKey:message];
    }
    
    ObserverEntry* entry = [[[ObserverEntry alloc] init] autorelease];
    entry.delegate = receiver;
    [entryArray addObject:entry];
    
    return YES;
}


- (BOOL) unRegisterMessage:(NSString*) message receiver:(id<IHSMessageObserver>) receiver {
    
    NSMutableArray* entryArray = [_messageDict objectForKey:message];
    
    if (isNull(entryArray) || [entryArray count] <= 0) {
        return YES;
    }
    
    ObserverEntry* tmpEntry = nil;
    
    for (ObserverEntry* entry in entryArray) {
        if (entry.delegate == receiver) {
            tmpEntry = entry;
            break;
        }
    }
    
    // remove from array
    if (nil != tmpEntry) {
        [entryArray removeObject:tmpEntry];        
    }
    
    return YES;
}

- (void) sendMessage:(NSString*) message paramObject:(id) paramObject paramLong:(long) paramLong {
    NSMutableArray* entryArray = [_messageDict objectForKey:message];
    
    if (isNull(entryArray) || [entryArray count] <= 0) {
        return ;
    }
    
    for (ObserverEntry* entry in entryArray) {
        id<IHSMessageObserver> observer = entry.delegate;
        apiLogDebug(@"count: %d",observer.retainCount);
        if (nil != observer && observer.retainCount > 0) {
            [observer receiveMessgeObserver:message paramObject:paramObject paramLong:paramLong];
        }
    }
}


@end
