//
//  GWTabBar.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWTabBar.h"
#import "GWTabBarButton.h"

@interface GWTabBar ()
@property(nonatomic,strong)NSMutableArray *tabBarButtons;
@property(nonatomic,weak)GWTabBarButton *selectedButton;
@property(nonatomic,weak)UIButton *addBtn;
@end

@implementation GWTabBar

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        //添加加号按钮
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [addBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        addBtn.bounds = CGRectMake(0, 0, addBtn.currentBackgroundImage.size.width, addBtn.currentBackgroundImage.size.height);
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn = addBtn;
        [self addSubview:addBtn];
    }
    return self;
}

-(void)addBtnClick
{
    //modal的形式 弹出控制器，发送微博
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickAddBtn:)]) {
        [self.delegate tabBarDidClickAddBtn:self];
    }
}



-(void)addTabBarBtnWithTabBarItem:(UITabBarItem *)item
{
    GWTabBarButton *btn = [[GWTabBarButton alloc]init];
    [self addSubview:btn];
    [self.tabBarButtons addObject:btn];

    btn.item = item;
    
    //点击按钮的点击
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //默认选择第一个按钮
    if (self.tabBarButtons.count == 1) {
        btn.selected = YES;
        _selectedButton = btn;
    }
    

    
}

-(void)btnClick:(GWTabBarButton *) btn
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:_selectedButton.tag to:btn.tag];
    }
    _selectedButton.selected = NO;
    btn.selected = YES;
    _selectedButton = btn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _addBtn.center = CGPointMake(w * 0.5, h * 0.5);
    
    int count = self.tabBarButtons.count;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonH = h;
    CGFloat buttonY = 0;
    for (int i = 0; i<count ; i++) {
        GWTabBarButton *btn = self.tabBarButtons[i];
        CGFloat buttonX = i * buttonW;
        if (i > 1) {
            buttonX += buttonW;
        }
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //绑定tag
        btn.tag = i;
    }
}

@end
