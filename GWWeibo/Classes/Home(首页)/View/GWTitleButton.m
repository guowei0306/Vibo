//
//  GWTitleButton.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-25.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#define GWTitleButtonImageW 20

#import "GWTitleButton.h"

@implementation GWTitleButton


+(instancetype)titleButton
{
    return [[GWTitleButton alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = GWTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - GWTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    //根据title计算自己的宽度
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    CGRect frame = self.frame;
    frame.size.width = frame.size.width + titleW + 5;
    self.frame = frame;
    [super setTitle:title forState:state];
}

@end
