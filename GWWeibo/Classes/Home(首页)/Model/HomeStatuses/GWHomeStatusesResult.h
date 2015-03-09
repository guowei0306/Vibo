//
//  GWHomeStatusesResult.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  封装加载微博首页返回结果

#import <Foundation/Foundation.h>

@interface GWHomeStatusesResult : NSObject

/**
 *   里面放的都是GWStatus模型数据
 */
@property(nonatomic,strong)NSArray *statuses;

@property(nonatomic,assign)long long previous_cursor;

@property(nonatomic,assign)long long next_cursor;

@property(nonatomic,assign)long long total_number;

@end
