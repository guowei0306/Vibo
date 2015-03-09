//
//  GWAccount.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWAccount.h"

@implementation GWAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[GWAccount alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象时调用
 */
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expireTime = [decoder decodeObjectForKey:@"expireTime"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件时调用
 */
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expireTime forKey:@"expireTime"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
