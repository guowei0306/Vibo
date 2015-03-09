//
//  GWAccountTool.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//
#define GWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "GWAccountTool.h"
#import "GWaccount.h"

@implementation GWAccountTool


+(void)saveAccount:(GWAccount *)account
{
    NSDate *now = [NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:account.expires_in];
    //存储模型,归档
    [NSKeyedArchiver archiveRootObject:account toFile:GWAccountFile];
}

+(GWAccount *)account
{
    GWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:GWAccountFile];
    NSDate *now = [NSDate date];
//   判断账号是否过期
    if ([now compare:account.expireTime] == NSOrderedAscending) {//还没有过期
        return account;
    }else{
        return nil;
    }
}

@end
