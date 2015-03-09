//
//  UIImage+GW.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GW)

//加载图片
+(UIImage *)imageWithName:(NSString *)name;

+(UIImage *)resizeImageWithName:(NSString *)name;

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end


