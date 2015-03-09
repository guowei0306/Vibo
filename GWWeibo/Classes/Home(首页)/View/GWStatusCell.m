//
//  GWStatusCell.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//


#import "GWStatusCell.h"
#import "GWStatusFrame.h"
#import "GWUser.h"
#import "GWStatus.h"
#import "UIImageView+WebCache.h"
#import "GWStatusToolBar.h"
#import "GWStatusTopView.h"

@interface GWStatusCell ()

/** 顶部的view */
@property(nonatomic,weak)GWStatusTopView *topView;

/** 微博的工具条 */
@property(nonatomic,weak)GWStatusToolBar *statusToolBar;

@end

@implementation GWStatusCell

#pragma mark
#pragma mark 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //1.定义一个可循环标识
    static NSString *ID = @"status";
    //2.去缓存池中取可循环利用cell
    GWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果缓存池中没有可循环利用的cell
    if (cell == nil) {
        cell = [[GWStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /**
         *  这里必须先创建原创微博内部子控件，再创建转发微博，否则转发微博就不会显示。因为retweetView是依赖topView展示的！！！
         */
        
        //1.添加顶部子控件
        [self setupTopSubviews];
        
        //2.添加底部控件
        [self setupStatusToolBar];
    }
    return self;
}

-(void)setupTopSubviews
{
    //去掉选中时的蓝色背景
    self.selectedBackgroundView = [[UIView alloc]init];
    self.backgroundColor = [UIColor clearColor];
    //添加最外面父控件
    GWStatusTopView *topView = [[GWStatusTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
}


-(void)setupStatusToolBar
{
    
    /** 微博的工具条 */
    GWStatusToolBar *statusToolBar = [[GWStatusToolBar alloc]init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}


#pragma mark 
#pragma mark 设置数据
-(void)setupTopDatas
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame  = self.statusFrame;
    
}


-(void)setupStatusToolBarDatas
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}


-(void)setStatusFrame:(GWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //1.设置顶部view的数据
    [self setupTopDatas];
    
    //2.设置微博工具条
    [self setupStatusToolBarDatas];
}




#pragma mark
#pragma mark 调整frame
/**  拦截frame的设置 */
-(void)setFrame:(CGRect)frame
{
    frame.origin.y += GWStatusTableBorder;
    frame.origin.x = GWStatusTableBorder;
    frame.size.width -= GWStatusTableBorder * 2;
    frame.size.height -= GWStatusTableBorder;
    [super setFrame:frame];
    
}

@end
