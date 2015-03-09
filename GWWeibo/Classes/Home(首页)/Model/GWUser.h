//
//  GWUser.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWUser : NSObject

/**
 *  昵称
 */
@property(nonatomic,copy)NSString *name;

/**
 *  头像缩略图
 */
@property(nonatomic,copy)NSString *profile_image_url;

/**
 *  用户ID
 */
@property(nonatomic,copy)NSString *idstr;

/**
 *  会员等级
 */
@property(nonatomic,assign)int mbrank;

/**
 *  会员类型 mbtype > 2 会员
 */
@property(nonatomic,assign)int mbtype;
@end
