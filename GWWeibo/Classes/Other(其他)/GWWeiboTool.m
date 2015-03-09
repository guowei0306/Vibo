//
//  GWWeiboTool.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWWeiboTool.h"
#import "GWTabBarController.h"
#import "GWNewfeatureViewController.h"

@implementation GWWeiboTool

+(void)chooseRootViewController
{

    NSString *key = @"CFBundleVersion";
    //取出沙盒中上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastCode = [defaults valueForKey:key];
    
    //获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([lastCode isEqualToString:currentVersion]) {//不显示新特性
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[GWTabBarController alloc]init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[GWNewfeatureViewController alloc]init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
}

@end
