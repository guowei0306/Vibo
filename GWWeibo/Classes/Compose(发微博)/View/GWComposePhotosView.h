//
//  GWPhotosView.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-5.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWComposePhotosView : UIView

/**
 *  添加图片
 */
-(void)addImage:(UIImage *)image;

/**
 *  返回所有图片
 */
-(NSArray *)totalImages;

@end
