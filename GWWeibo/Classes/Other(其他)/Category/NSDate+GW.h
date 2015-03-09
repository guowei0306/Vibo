//
//  NSDate+GW.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-28.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GW)

/**
 *  是否今天
 */
-(BOOL)iSToday;

/**
 *  是否昨天
 */
-(BOOL)isYesterday;

/**
 *   是否今年
 */
-(BOOL) isThisYear;

/**
 *  获得与当前时间的差距
 */
-(NSDateComponents *)deltaWithNow;

/**
 *  返回YMD时间的日期
 */
-(NSDate *)dateWithYMD;

@end
