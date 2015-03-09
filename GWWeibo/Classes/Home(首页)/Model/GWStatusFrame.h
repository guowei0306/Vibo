//
//  GWStatusFrame.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-27.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GWStatus;
@interface GWStatusFrame : NSObject

@property(nonatomic,strong)GWStatus *status;


/**
 *  顶部的view
 */
@property(nonatomic,assign,readonly)CGRect topViewF;
/**
 *  头像
 */
@property(nonatomic,assign,readonly)CGRect iconViewF;
/**
 *  会员图标
 */
@property(nonatomic,assign,readonly)CGRect vipViewF;
/**
 *  图片
 */
@property(nonatomic,assign,readonly)CGRect photoViewF;
/**
 *  昵称
 */
@property(nonatomic,assign,readonly)CGRect nameLabelF;
/**
 *  时间
 */
@property(nonatomic,assign,readonly)CGRect timeLabelF;
/**
 *  来源
 */
@property(nonatomic,assign,readonly)CGRect sourceLabelF;
/**
 *  正文
 */
@property(nonatomic,assign,readonly)CGRect contentLabelF;

/**
 *  被转发的父view
 */
@property(nonatomic,assign,readonly)CGRect retWeetViewF;

/**
 *  被转发作者昵称
 */
@property(nonatomic,assign,readonly)CGRect retWeetNameLabelF;
/**
 *  被转发正文
 */
@property(nonatomic,assign,readonly)CGRect retWeetContentLabelF;
/**
 *  被转发配图
 */
@property(nonatomic,assign,readonly)CGRect retWeetPhotoViewF;
/**
 *  微博的工具条
 */
@property(nonatomic,assign,readonly)CGRect statusToolBarF;
/**
 *  微博cell的高度
 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@end
