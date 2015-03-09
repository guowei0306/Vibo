//
//  GWUserInfoParam.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  用户信息的请求参数

#import <Foundation/Foundation.h>
#import "GWBaseParam.h"

@interface GWUserInfoParam : GWBaseParam

/**
 *  用户ID
 */
@property(nonatomic,strong)NSNumber *uid;

/**
 *  用户昵称
 */
@property(nonatomic,copy)NSString *screen_name;


@end
