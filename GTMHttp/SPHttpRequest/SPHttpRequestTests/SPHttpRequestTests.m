//
//  SPHttpRequestTests.m
//  SPHttpRequestTests
//
//  Created by doujingxuan on 13-6-18.
//  Copyright (c) 2013年 SpriteApp Inc. All rights reserved.
//

#import "SPHttpRequestTests.h"

@implementation SPHttpRequestTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    NSLog(@"test");
    [self testSPHttpRequestBlock];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in SPHttpRequestTests");
}
-(void)testSPHttpRequestBlock
{
    SPHttpRequest * req = [[[SPHttpRequest alloc] initWithURL:[NSURL URLWithString:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php"] timeOut:30.0f] autorelease];
    [req setPostValue:@"63.223.108.42" forKey:@"ip"];
    [req setPostValue:@"json" forKey:@"format"];
    
//    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:10];
//    [dict setObject:@"63.223.108.42" forKey:@"ip"];
//    [dict setObject:@"json" forKey:@"format"];
    
    
    [req setDidFinishSelector:@selector(testFinishRequest:)];
    [req setDidFailSelector:@selector(testFailedRequest:)];
    [req setDelegate:self];
    [req setCompletedBlock:^(NSData*data){
        if (nil == data) {
            return;
        }
        
        NSString *  retrievedString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@" block retrievedString is %@",retrievedString);
    }];
    [req setFailedBlock:^(NSError*error){
        NSLog(@"block error is %@",error);
    }];
    [req startAsyncSPHttpRequest];
}
@end
