//
//  GWStatusTool.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWStatusTool.h"
#import "GWHttpTool.h"
#import "MJExtension.h"

@implementation GWStatusTool

+(void)homeStatusWithParam:(GWHomeStatusesParam *)param success:(void (^)(GWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [GWHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            GWHomeStatusesResult *result = [GWHomeStatusesResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)sendStatusWithParam:(GWSendStatusParam *)param success:(void (^)(GWSendStatusResult *))success failure:(void (^)(NSError *))failure
{

}

@end
