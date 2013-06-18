//
//  AppDelegate.m
//  CometTest
//
//  Created by doujingxuan on 13-6-12.
//  Copyright (c) 2013年 FCNN Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatDemoVC.h"


@implementation AppDelegate

- (void)dealloc
{
    [self removeAllNotifications];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [self monitorNetWork];
    
    
    ChatDemoVC * chatVC = [[ChatDemoVC alloc] init];
    UINavigationController * nav = [[UINavigationController  alloc] initWithRootViewController:chatVC];
    [chatVC release];
    self.window.rootViewController = nav;
    [nav release];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma 网络实时监控
-(void)monitorNetWork
{
    Reachability * hostReach = [[Reachability reachabilityWithHostName: @"www.baidu.com"] retain];
	[hostReach startNotifier];
    [self addNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkType:) name:kReachabilityChangedNotification object:hostReach];

}
#pragma mark
#pragma 网络变化的通知
-(void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorNetWork) name:START_MONITOR_NERWORK object:nil];
}
-(void)removeAllNotifications
{
    [[NSNotificationCenter defaultCenter] removeAllNotifications];
}
-(void)netWorkType:(NSNotification*)notification
{
    Reachability* currentReach = [notification object];
    NetworkStatus netStatus = [currentReach currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:{
            NSLog(@"没网");
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_NO_NETWORK object:nil];
        }
            break;
        case ReachableViaWiFi:{
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_WIFI object:nil];
        }
            break;
        case ReachableViaWWAN:{
            NSLog(@"3G网络或者2G网络");
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_2G_OR_3G object:nil];
            
        }
            break;
            
        default:
            break;
    }
}
@end
