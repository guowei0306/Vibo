//
//  UIBarButtonItem+GW.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-25.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GW)


+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon action:(SEL)action target:(id)target;
@end
