//
//  GWHttpTool.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-5.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  网络通用工具类

#import <Foundation/Foundation.h>

@interface GWHttpTool : NSObject

//发送请求，异步，不能直接返回值，而是利用block回调

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;



@end

/**
 *  formData数据
 */
@interface GWFormData : NSObject

/**
 *  文件数据
 */
@property(nonatomic,strong)NSData *data;

/**
 *  参数名
 */
@property(nonatomic,copy)NSString *name;

/**
 *  文件名
 */
@property(nonatomic,copy)NSString *filename;

/**
 *  文件类型
 */
@property(nonatomic,copy)NSString *mimeType;

@end