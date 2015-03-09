//
//  GWAppDelegate.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWAppDelegate.h"
#import "GWWeiboTool.h"
#import "GWOAuthViewController.h"
#import "GWAccount.h"
#import "GWAccountTool.h"
#import "SDWebImageManager.h"

@implementation GWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    //有无存储账号信息
    GWAccount *account = [GWAccountTool account];
    if (account) {//登陆成功
        [GWWeiboTool chooseRootViewController];
    }else{//之前没有登录成功
        self.window.rootViewController = [[GWOAuthViewController alloc]init];
    }

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
    //在后台开启任务，让程序继续运行。但是能保持运行的时间是不确定的。
    //这种方法是暂时性的
    [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    //定时提醒(定时弹框)
//    [UILocalNotification]
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

/**
 *  收到内存警告时调用
 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //清楚内存中的图片
    //1.停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    //2.清楚已下载的内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
