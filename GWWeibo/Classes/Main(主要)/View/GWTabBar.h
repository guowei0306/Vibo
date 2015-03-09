//
//  GWTabBar.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GWTabBar;
@protocol GWTabBarDelegate <NSObject>

@optional
-(void)tabBar:(GWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
-(void)tabBarDidClickAddBtn:(GWTabBar *)tabBar;
@end

@interface GWTabBar : UIView

@property(nonatomic,weak) id<GWTabBarDelegate> delegate;
-(void)addTabBarBtnWithTabBarItem:(UITabBarItem *)item;

@end
