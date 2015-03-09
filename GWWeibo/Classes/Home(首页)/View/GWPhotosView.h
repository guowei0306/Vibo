//
//  GWPhotosView.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-1.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWPhotosView : UIView

/** 相片数组*/
@property(nonatomic,strong)NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end
