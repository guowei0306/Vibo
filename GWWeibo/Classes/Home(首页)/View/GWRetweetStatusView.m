//
//  GWRetweetStatusView.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-28.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWRetweetStatusView.h"
#import "GWStatusFrame.h"
#import "GWUser.h"
#import "GWStatus.h"
#import "UIImageView+WebCache.h"
#import "GWPhoto.h"
#import "GWPhotosView.h"

@interface GWRetweetStatusView ()
/**
 *  被转发作者昵称
 */
@property(nonatomic,weak)UILabel *retWeetNameLabel;
/**
 *  被转发正文
 */
@property(nonatomic,weak)UILabel *retWeetContentLabel;
/**
 *  被转发配图
 */
@property(nonatomic,weak)GWPhotosView *retWeetPhotoView;

@end

@implementation GWRetweetStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left: 0.9 top:0.5];
        /**
         *  被转发作者昵称
         */
        UILabel *retWeetNameLabel = [[UILabel alloc]init];
        retWeetNameLabel.font = GWRetWeetStatusNameFont;
        retWeetNameLabel.backgroundColor = [UIColor clearColor];
        retWeetNameLabel.textColor = GWColor(67, 107, 103);
        [self addSubview:retWeetNameLabel];
        self.retWeetNameLabel = retWeetNameLabel;
        /**
         *  被转发正文
         */
        UILabel *retWeetContentLabel = [[UILabel alloc]init];
        retWeetContentLabel.font = GWRetWeetStatusContentFont;
        retWeetContentLabel.backgroundColor = [UIColor clearColor];
        retWeetContentLabel.textColor = GWColor(90, 90, 90);
        retWeetContentLabel.numberOfLines = 0;
        [self addSubview:retWeetContentLabel];
        self.retWeetContentLabel = retWeetContentLabel;
        /**
         *  被转发配图
         */
        GWPhotosView *retWeetPhotoView = [[GWPhotosView alloc]init];
        [self addSubview:retWeetPhotoView];
        self.retWeetPhotoView = retWeetPhotoView;
    }
    return self;
}


-(void)setStatusFrame:(GWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    GWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    GWUser *retweetUser = retweetStatus.user;
    
    //昵称
    self.retWeetNameLabel.text = [NSString stringWithFormat:@"@%@",retweetUser.name];
    self.retWeetNameLabel.frame = self.statusFrame.retWeetNameLabelF;
    
    //文字
    self.retWeetContentLabel.text = retweetStatus.text;
    self.retWeetContentLabel.frame = self.statusFrame.retWeetContentLabelF;
    
    
    //配图
    if (retweetStatus.pic_urls.count) {
        self.retWeetPhotoView.hidden = NO;
        self.retWeetPhotoView.frame = self.statusFrame.retWeetPhotoViewF;
        self.retWeetPhotoView.photos = retweetStatus.pic_urls;
    }else{
        self.retWeetPhotoView.hidden = YES;
        
    }
}

@end
