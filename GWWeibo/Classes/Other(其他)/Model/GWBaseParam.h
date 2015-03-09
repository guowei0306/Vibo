//
//  GWBaseParam.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-9.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWBaseParam : NSObject

@property(nonatomic,copy)NSString *access_token;

+(instancetype)param;

@end
