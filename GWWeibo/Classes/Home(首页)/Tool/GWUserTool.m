//
//  GWUserTool.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWUserTool.h"
#import "GWHttpTool.h"
#import "MJExtension.h"

@implementation GWUserTool


+(void)userInfoWithParam:(GWUserInfoParam *)param success:(void (^)(GWUserInfoResult *result))success failure:(void (^)(NSError *error))failure
{
    [GWHttpTool getWithUrl:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            GWUserInfoResult *result = [GWUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

+(void)userUnreadCountParam:(GWUserUnreadCountParam *)param success:(void (^)(GWUserUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [GWHttpTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            GWUserUnreadCountResult *result = [GWUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
