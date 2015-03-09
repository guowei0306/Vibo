//
//  GWAccountTool.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GWAccount;

@interface GWAccountTool : NSObject
/**
 *  存储账号信息
 */
+(void)saveAccount:(GWAccount *)account;

/**
 *  获取账号信息
 */
+(GWAccount *)account;
@end
