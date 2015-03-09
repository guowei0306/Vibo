//
//  GWStatus.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  

#import "GWStatus.h"
#import "GWUser.h"
#import "NSDate+GW.h"
#import "MJExtension.h"
#import "GWPhoto.h"

@implementation GWStatus

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [GWPhoto class]};
}

/**
 *  重写得到时间的方法
 *
 *  @return 发微博的时间
 */

#pragma mark 时间 格式化
-(NSString *)created_at
{
    /**
     获得微博发送时间
     */
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MM dd HH:mm:ss Z yyyy";
#warning 真机调试必须加上这句话，设定时区，才能解析 EEE MM dd HH:mm:ss Z yyyy
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en-US"];
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    /**
     *  对比当前时间
     */
    if (createDate.iSToday) {//今天
        if (createDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前",createDate.deltaWithNow.hour];
        }else if(createDate.deltaWithNow.hour < 1 && createDate.deltaWithNow.minute > 1){
            return [NSString stringWithFormat:@"%d分钟前",createDate.deltaWithNow.minute];
        }else{
            return @"刚刚";
        }
    }else if(createDate.isYesterday){//昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if(createDate.isThisYear){//今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}


#pragma mark 来源 格式化
-(void)setSource:(NSString *)source
{
     _source = @"";
    if (![source isEqualToString:@""]) {
        int loc = [source rangeOfString:@">"].location + 1;
        int len = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, len)];
        _source = [NSString stringWithFormat:@"来自 %@",source];
    }
    
}


@end
