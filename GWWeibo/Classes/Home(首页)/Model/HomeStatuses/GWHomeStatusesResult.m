//
//  GWHomeStatusesResult.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-8.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWHomeStatusesResult.h"
#import "MJExtension.h"
#import "GWStatus.h"

@implementation GWHomeStatusesResult

-(NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [GWStatus class]};
}

@end

