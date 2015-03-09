//
//  GWUserUnreadCountResult.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-9.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWUserUnreadCountResult.h"

@implementation GWUserUnreadCountResult

-(int)messageCount
{
    return self.mention_cmt + self.mention_status + self.dm + self.cmt;
}

-(int)count
{
    return self.messageCount + self.follower + self.status;
}

@end
