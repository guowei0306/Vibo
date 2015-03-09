//
//  GWAccount.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  用户账号

#import <Foundation/Foundation.h>

@interface GWAccount : NSObject<NSCoding>
//如果服务器返回数字很大，建议用longlong（比如说主键ID）
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;
@property(nonatomic,strong)NSDate *expireTime;//账号过期时间
/** 用户昵称 */
@property(nonatomic,copy)NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
