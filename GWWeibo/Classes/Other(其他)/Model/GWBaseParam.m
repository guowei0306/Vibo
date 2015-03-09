//
//  GWBaseParam.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-9.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWBaseParam.h"
#import "GWAccountTool.h"
#import "GWAccount.h"

@implementation GWBaseParam

-(id)init
{
    if (self = [super init]) {
        self.access_token = [GWAccountTool account].access_token;
    }
    return self;
}

+(instancetype)param
{
    return [[self alloc]init];
}
@end
