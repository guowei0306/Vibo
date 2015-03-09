//
//  GWUserTool.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWUserInfoParam.h"
#import "GWUserInfoResult.h"
#import "GWUserUnreadCountParam.h"
#import "GWUserUnreadCountResult.h"

@interface GWUserTool : NSObject

/**
 *  加载首页的用户数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)userInfoWithParam:(GWUserInfoParam *)param success:(void (^)(GWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

+(void)userUnreadCountParam:(GWUserUnreadCountParam *)param success:(void (^)(GWUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
