//
//  GWStatusTopView.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-28.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWStatusTopView.h"
#import "GWStatusFrame.h"
#import "GWStatus.h"
#import "GWUser.h"
#import "UIImageView+WebCache.h"
#import "GWRetweetStatusView.h"
#import "GWPhoto.h"
#import "GWPhotosView.h"

@interface GWStatusTopView ()

/**
 *  头像
 */
@property(nonatomic,weak)UIImageView *iconView;
/**
 *  会员图标
 */
@property(nonatomic,weak)UIImageView *vipView;
/**
 *  图片
 */
@property(nonatomic,weak)GWPhotosView *photoView;
/**
 *  昵称
 */
@property(nonatomic,weak)UILabel *nameLabel;
/**
 *  时间
 */
@property(nonatomic,weak)UILabel *timeLabel;
/**
 *  来源
 */
@property(nonatomic,weak)UILabel *sourceLabel;
/**
 *  正文
 */
@property(nonatomic,weak)UILabel *contentLabel;


/**
 *  被转发的父view
 */
@property(nonatomic,weak)GWRetweetStatusView *retWeetView;

@end

@implementation GWStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
        /**
         头像
         */
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        /**
         会员
         */
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        /**
         配图
         */
        GWPhotosView *photoView = [[GWPhotosView alloc]init];
        [self addSubview:photoView];
        self.photoView = photoView;
        /**
         昵称
         */
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = GWStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        /**
         时间
         */
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = GWStatusTimeFont;
        timeLabel.textColor = GWColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        /**
         来源
         */
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = GWStatusSourceFont;
        sourceLabel.textColor =GWColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        /**
         文字内容
         */
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = GWStatusContentFont;
        contentLabel.textColor = GWColor(39, 39, 39);
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        /**
         *  被转发的父view
         */
        GWRetweetStatusView *retWeetView = [[GWRetweetStatusView alloc]init];
        [self addSubview:retWeetView];
        self.retWeetView = retWeetView;
    }
    return self;
}

-(void)setStatusFrame:(GWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    GWStatus *status = self.statusFrame.status;
    GWUser *user = status.user;
    
    GWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    //4.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.nameLabelF) + GWStatusCellBorder * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:GWStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    //5.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + GWStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:GWStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //6.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //7.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        [self.vipView setImage:[UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]]];
        self.vipView.frame = self.statusFrame.vipViewF;
    }else{
        self.vipView.hidden = YES;
    }
    
    //8.配图
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;//没有frame不会显示
        self.photoView.photos = status.pic_urls;
    }else{
        self.photoView.hidden = YES;
    }
    
    
    //9.被转发父控件
    if (retweetStatus) {
        self.retWeetView.hidden = NO;
        self.retWeetView.frame = self.statusFrame.retWeetViewF;
        
        self.retWeetView.statusFrame = self.statusFrame;
        
    } else {
        self.retWeetView.hidden = YES;
    }
    
}

@end
