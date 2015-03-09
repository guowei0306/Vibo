//
//  GWComposeToolBar.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-4.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWComposeToolBar.h"

@implementation GWComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        //2.设置按钮
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:GWComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:GWComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:GWComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:GWComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:GWComposeToolbarButtonTypeEmotion];
    }
    return self;
}

-(void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:btn];
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickedButton:)]) {
        [self.delegate composeToolBar:self didClickedButton:btn.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(i * buttonW, buttonY, buttonW, buttonH);
    }
}


@end
