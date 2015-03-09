//
//  GWSendStatusParam.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  封装发微博的参数

#import <Foundation/Foundation.h>
#import "GWBaseParam.h"

@interface GWSendStatusParam : GWBaseParam

/**
 *  发送的微博
 */
@property(nonatomic,copy)NSString *status;

@end
