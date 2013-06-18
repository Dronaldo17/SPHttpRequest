//
//  ChatDemoVC.m
//  CometTest
//
//  Created by doujingxuan on 13-6-12.
//  Copyright (c) 2013年 FCNN Inc. All rights reserved.
//

#import "ChatDemoVC.h"
#import "JSON.h"

@interface ChatDemoVC ()

@end

@implementation ChatDemoVC
@synthesize xsrf,sendString,receiveString;
- (void)dealloc
{
    [self clearAuthRequest];
    [self clearReceiveRequest];
    [self removeAllNotifications];
    self.xsrf = nil;
    self.sendString = nil;
    self.receiveString = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:START_MONITOR_NERWORK object:nil];
    // Do any additional setup after loading the view from its nib.
   self.xsrf = [DRTools getValueFromNSUserDefaultsByKey:XSRF];
    if ([self.xsrf length] > 0) {
        [self reciveMessage];
    }
    else{
        [self authlogin];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self addNotifications];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma 按钮响应事件
-(IBAction)sendMessage:(id)sender
{
    [_inputBox resignFirstResponder];
    NSString * sendMessage = [_inputBox text];
    [_inputBox setText:@""];
    [self updateUIFromSpeaker:sendMessage byMessage:sendMessage];
    [self sendMessageRequestWithMessage:sendMessage];
}
-(IBAction)handUpdateMessage:(id)sender
{
    if (_receiveRequest) {
        [_receiveRequest clearDelegatesAndCancelRequest];
        _receiveRequest = nil;
    }
    [self reciveMessage];
}
#pragma 生成comet 请求
-(void)authlogin
{
    NSURL * url = [NSURL URLWithString:LOGIN_API];
    
    if (!_authLoginRequest) {
        _authLoginRequest = [[SPHttpRequest alloc] initWithURL:url timeOut:TimeOut];
    }
    
    [_authLoginRequest setDelegate:self];
    [_authLoginRequest setDidFinishSelector:@selector(authSuccess:)];
    [_authLoginRequest setDidFailSelector:@selector(authFailed:)];
    [_authLoginRequest startAsyncSPHttpRequest];
}
-(void)reciveMessage
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSURL * url = [NSURL URLWithString:RECEIVE_API];
    
    if (!_receiveRequest) {
        _receiveRequest = [[SPHttpRequest alloc] initWithURL:url timeOut:TimeOut];
    }
//    [_receiveRequest  setRequestMethod:@"POST"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_receiveRequest  setPostValue:self.xsrf forKey:XSRF];
//    _receiveRequest.reuqestMethod = @"POST";
    
    [self setATimeStampByType:@"请求发起时间"];

    [_receiveRequest setDidFinishSelector:@selector(receiveMessageSuccess:)];
    [_receiveRequest setDidFailSelector:@selector(receiveMessageFailed:)];
    [_receiveRequest setDelegate:self];
    
    [_receiveRequest startAsyncSPHttpRequest];
}
-(void)updateUIFromSpeaker:(NSString*)speaker byMessage:(NSString*)message
{
     _textView.text =[NSString stringWithFormat:@"%@\r\n%@",_textView.text,message];
}
/**Author:Ronaldo Description:发送需要另外字段  暂无法准确捕获*/
-(void)sendMessageRequestWithMessage:(NSString*)message
{
    if ( nil == message || [message length] <= 0) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"所发信息不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [av show];
        [av release];
    }
    else{
       NSURL * url = [NSURL URLWithString:SEND_API];
////        d5273872-f7e7-4e3a-a26d-58da17e72c75
//        __block  ASIFormDataRequest * sendRequest = [ASIFormDataRequest requestWithURL:url];
////        Block_copy(sendRequest);
//        [sendRequest setPostValue:self.xsrf forKey:XSRF];
//        [sendRequest setPostValue:message forKey:@"body"];
//        
//        [sendRequest setCompletionBlock:^{
//            NSString * responseString = [sendRequest responseString];
//            NSLog(@"responseString is %@",responseString);
////            Block_release(sendRequest);
//        }];
//        [sendRequest setFailedBlock:^{
//            NSLog(@"error is %@",[sendRequest error]);
////            Block_release(sendRequest);
//        }];
//        
//        [sendRequest startAsynchronous];
        
        
        SPHttpRequest * sendRequest = [[[SPHttpRequest alloc] initWithURL:url timeOut:TimeOut] autorelease];
        [sendRequest setPostValue:self.xsrf forKey:XSRF];
        [sendRequest setPostValue:message forKey:@"body"];
        
        [sendRequest setCompletedBlock:^(NSData*data){
            NSString *  retrievedString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
            NSLog(@" sel retrievedString is %@",retrievedString);
        }];
        [sendRequest setFailedBlock:^(NSError* error){
            NSLog(@"error is %@",[error localizedDescription]);
            [DRTools tapAlertWithMessage:@"发送失败"];
        }];
        [sendRequest  startAsyncSPHttpRequest];
    }

}
-(void)setATimeStampByType:(NSString*)type
{
    NSString * waitString = [DRTools stringFromADate:[NSDate date] withFormat:@"hh:mm:ss"];
    
    [self updateUIFromSpeaker:nil byMessage:[NSString stringWithFormat:@"%@:%@",type,waitString]];
    
}
-(void)clearReceiveRequest
{
    if (_receiveRequest) {
        [_receiveRequest clearDelegatesAndCancelRequest];
        [_receiveRequest release];
        _receiveRequest = nil;

    }
}
-(void)clearAuthRequest
{
    if (_authLoginRequest) {
        [_authLoginRequest clearDelegatesAndCancelRequest];
        [_authLoginRequest release];
        _authLoginRequest = nil;
    }
}
-(void)receiveMessageSuccess:(NSData*)data
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self setATimeStampByType:@"成功接受消息时间"];
    
    
    if (nil == data) {
        return;
    }
    
    NSString *  retrievedString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"retrievedString is %@",retrievedString);
    NSMutableDictionary * dict = [retrievedString JSONValue];
    NSLog(@"dict is %@",dict);
    NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithCapacity:2];
    tmpDict = dict[@"messages"][0];
    
    NSString * receivedMessage = [NSString stringWithFormat:@"%@:%@",tmpDict[@"from"],tmpDict[@"body"]];
    [self updateUIFromSpeaker:SPEAKER_OTHER byMessage:receivedMessage];
    [self clearReceiveRequest];
    [self reciveMessage];
}
-(void)receiveMessageFailed:(NSError*)error
{
    [self setATimeStampByType:@"请求失败重连时间"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    NSString * errorMessage = [DRTools parseHttpError:error];
    NSLog(@"error is %@",[error localizedDescription]);
    [self clearReceiveRequest];
    [self reciveMessage];
}

#pragma mark  键盘的收起
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self sendMessage:nil];
    return YES;
}

#pragma 监控网络
-(void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetWork:) name:NETWORK_NO_NETWORK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkIsOK:) name:NETWORK_WIFI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkIsOK:) name:NETWORK_2G_OR_3G object:nil];
}
-(void)removeAllNotifications
{
    [[NSNotificationCenter defaultCenter] removeAllNotifications];
}
-(void)noNetWork:(NSNotification*)notification
{
    [self clearReceiveRequest];
}
-(void)networkIsOK:(NSNotification*)notification
{
    if (_receiveRequest) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    else{
        [self reciveMessage];
    }
}
#pragma GTMHttp请求
-(void)authSuccess:(NSData*)data
{
    NSDictionary * dict = _authLoginRequest.gtmRequest.responseHeaders;
//    NSLog(@"responseCookies is %@",responseCookies);
//    NSHTTPCookie * cooke = [responseCookies objectAtIndex:0];
//     = cooke.properties;
    NSLog(@"dict is %@",dict);
    NSLog(@"cookie is %@",dict[@"Set-Cookie"]);
    NSString * cookieString = [[dict[@"Set-Cookie"] componentsSeparatedByString:@";"] objectAtIndex:0];
    cookieString = [[cookieString componentsSeparatedByString:@"="] objectAtIndex:1];
    
    NSLog(@"cookieString is %@",cookieString);
    self.xsrf = cookieString;
    
    [DRTools syncNSUserDeafaultsByKey:XSRF withValue:self.xsrf];
    [_authLoginRequest clearDelegatesAndCancelRequest];
    [_authLoginRequest release];
    _authLoginRequest = nil;
    [self reciveMessage];
}
-(void)authFauled:(NSError*)error
{
    NSLog(@"error is %@",error);
    [_authLoginRequest clearDelegatesAndCancelRequest];
    [_authLoginRequest release];
    _authLoginRequest = nil;
}

@end
