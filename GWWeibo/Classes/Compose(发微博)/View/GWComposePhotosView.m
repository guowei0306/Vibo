//
//  GWPhotosView.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-5.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWComposePhotosView.h"

@implementation GWComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSArray *)totalImages
{
    NSArray *totalArray = [NSArray array];
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        UIImage *image = imageView.image;
        [array addObject:image];
    }
    totalArray = array;
    return totalArray;
}


-(void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int maxColumns = 4;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = (i % maxColumns) * (imageViewW + margin) + margin;
        CGFloat imageViewY = (i / maxColumns ) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}



@end
