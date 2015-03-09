//
//  UIImage+GW.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "UIImage+GW.h"

@implementation UIImage (GW)

+(UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {//iOS7
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *img = [UIImage imageNamed:newName];
        if (img == nil) {
            img = [UIImage imageNamed:name];
        }
        return img;
    }// 非iOS7
    return [UIImage imageNamed:name];
}

+(UIImage *)resizeImageWithName:(NSString *)name
{
    return [self resizeImageWithName:name left:0.5 top:0.5];
}

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
    return image;
}
@end
