//
//  GWStatusTool.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GWHomeStatusesParam.h"
#import "GWHomeStatusesResult.h"
#import "GWSendStatusParam.h"
#import "GWSendStatusResult.h"

@interface GWStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)homeStatusWithParam:(GWHomeStatusesParam *)param success:(void (^)(GWHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

+(void)sendStatusWithParam:(GWSendStatusParam *)param success:(void (^)(GWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end
