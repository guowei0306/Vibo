//
//  GWStatusFrame.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-27.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//
//cell边框宽度

#import "GWStatusFrame.h"
#import "GWStatus.h"
#import "GWUser.h"
#import "GWPhoto.h"
#import "GWPhotosView.h"


@interface GWStatusFrame  ()


@end
@implementation GWStatusFrame

/**
 *  获得微博模型后，计算frame
 */
-(void)setStatus:(GWStatus *)status
{
    _status = status;
    
    //cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * GWStatusTableBorder;
    
    //topview
    CGFloat topW = cellW;
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topH = 0;
    
    //头像
    CGFloat iconWH = 40;
    CGFloat iconX = GWStatusCellBorder;
    CGFloat iconY = GWStatusCellBorder;
    _iconViewF =  CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + GWStatusCellBorder;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:GWStatusNameFont];
    _nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //会员
    if (status.user.mbtype > 2) {
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) + GWStatusCellBorder;
        CGFloat vipY = nameY;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //时间
    CGFloat timeX = CGRectGetMaxX(_iconViewF) + GWStatusCellBorder;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + GWStatusCellBorder * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:GWStatusTimeFont];
    _timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + GWStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:GWStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //文字内容
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + GWStatusCellBorder;
    CGFloat contentW = topW - 2 * GWStatusCellBorder;
    CGSize contentSize = [status.text sizeWithFont:GWStatusContentFont constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentX,contentY},contentSize};

    //配图
    if (status.pic_urls.count) {
        CGSize photoSize = [GWPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + GWStatusCellBorder;
        _photoViewF = CGRectMake(photoX, photoY, photoSize.width , photoSize.height);
    }
    
    if (status.retweeted_status) {
        //被转发微博view
        CGFloat retweetViewW = contentW;
        CGFloat retweetViewH = 0;
        CGFloat retweetViewX = contentX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + GWStatusCellBorder * 0.5;
        
        //昵称呢CGFloat
        CGFloat retweetNameY = GWStatusCellBorder;
        CGFloat retweetNameX = GWStatusCellBorder;
        CGSize retweetNameSize = [[NSString stringWithFormat:@"@%@",status.retweeted_status.user.name] sizeWithFont:GWRetWeetStatusNameFont];
        _retWeetNameLabelF = (CGRect){{retweetNameX,retweetNameY},retweetNameSize};
        
        
        //正文
        CGFloat retweetContentX = retweetNameX;
        CGFloat retweetContentY = CGRectGetMaxY(_retWeetNameLabelF) + GWStatusCellBorder * 0.5;
        CGFloat retweetContentW = retweetViewW - 2 * GWStatusCellBorder;
        CGSize retweetContentSize = [status.retweeted_status.text sizeWithFont:GWRetWeetStatusContentFont constrainedToSize:CGSizeMake(retweetContentW, MAXFLOAT)];
        _retWeetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        //配图
        if (status.retweeted_status.pic_urls.count) {
            CGSize reweetPhotosSize = [GWPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotoX = contentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(_retWeetContentLabelF) + GWStatusCellBorder;
            _retWeetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, reweetPhotosSize.width, reweetPhotosSize.height);
            
            retweetViewH = CGRectGetMaxY(_retWeetPhotoViewF);
        }else{
            retweetViewH = CGRectGetMaxY(_retWeetContentLabelF);

        }
        retweetViewH += GWStatusCellBorder;
        _retWeetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        //有转发
        topH = CGRectGetMaxY(_retWeetViewF);
    }else{
        //无转发
        if (status.pic_urls.count) {
            topH = CGRectGetMaxY(_photoViewF);
        }else{
            topH = CGRectGetMaxY(_contentLabelF);
        }
        
    }
    topH += GWStatusCellBorder;
    _topViewF = CGRectMake(topX, topY, topW, topH);
    
    //工具条frame
    CGFloat statusToolBarX = topX;
    CGFloat statusToolBarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolBarW = topW;
    CGFloat statusToolBarH = 35;
    _statusToolBarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + GWStatusTableBorder;
}


@end
