//
//  GWPhotoView.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-1.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWPhotoView.h"
#import "GWPhoto.h"
#import "UIImageView+WebCache.h"

@interface GWPhotoView()

@property(nonatomic,weak)UIImageView *gifView;
@end

@implementation GWPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *gif = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifview = [[UIImageView alloc]initWithImage:gif];
        [self addSubview:gifview];
        _gifView = gifview;
    }
    return self;
}

-(void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
    
}


@end
