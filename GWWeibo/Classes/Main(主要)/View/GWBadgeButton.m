//
//  GWBadgeButton.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-9.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWBadgeButton.h"

@implementation GWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    //badgeValue不为空并且不等于0的时候显示
    if (badgeValue && [badgeValue intValue] != 0) {
        //设置可见
        self.hidden = NO;
        //设置标题
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置frame
        CGRect frame = self.frame;
        CGFloat btnW = self.currentBackgroundImage.size.width;
        CGFloat btnH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeSize.width += 10;
        }
        frame.size.width = btnW;
        frame.size.height = btnH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
}

@end
