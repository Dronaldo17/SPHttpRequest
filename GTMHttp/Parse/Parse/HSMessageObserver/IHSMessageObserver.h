//
//  IHSMessageObserver.h
//  common
//
//  Created by Ronaldo on 5/23/12.
//  Copyright (c) 2012 Tsinghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IHSMessageObserver <NSObject>

- (void) receiveMessgeObserver:(NSString*) message 
                   paramObject:(id) paramObject paramLong:(long) paramLong ;

@end
