//
//  GWSearchBar.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-25.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//


@interface GWSearchBar ()

@end
#import "GWSearchBar.h"

@implementation GWSearchBar

+(instancetype)searchBar
{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景（只拉伸中间）
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];
        
        //放大镜
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
       
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //删除叉叉
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //字体
        self.font = [UIFont systemFontOfSize:13];
        NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
        textDict[UITextAttributeTextColor] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:textDict];
        
        //键盘右下角样式
        self.returnKeyType = UIReturnKeySearch;
        //自动检查搜索按钮能否点击
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

/**
 *  这个方法才能得到正确的尺寸
 */
#pragma 布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30, 30);
}



@end
