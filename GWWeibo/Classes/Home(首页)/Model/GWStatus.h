//
//  GWStatus.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  一个status对象就是一条微博

#import <Foundation/Foundation.h>

@class GWUser;

@interface GWStatus : NSObject
/**
 *  微博文字
 */
@property(nonatomic,copy)NSString *text;

/**
 *  时间
 */
@property(nonatomic,copy)NSString *created_at;

/**
 *  微博来源
 */
@property(nonatomic,copy)NSString *source;

/**
 *  微博ID
 */
@property(nonatomic,copy)NSString *idstr;

/**
 *  转发数
 */
@property(nonatomic,assign)int reposts_count;

/**
 *  评论数
 */
@property(nonatomic,assign)int comments_count;

/**
 *  表态数
 */
@property(nonatomic,assign)int attitudes_count;

/**
 *  用户
 */
@property(nonatomic,strong)GWUser *user;

/**
 *  单张配图
 */
@property(nonatomic,strong)NSArray *pic_urls;
//@property(nonatomic,copy)NSString *thumbnail_pic;

/**
 *  转发的微博
 */
@property(nonatomic,strong)GWStatus *retweeted_status;
@end
