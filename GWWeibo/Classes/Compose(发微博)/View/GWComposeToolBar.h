//
//  GWComposeToolBar.h
//  GWWeibo
//
//  Created by 郭薇 on 14-12-4.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GWComposeToolBar;

typedef enum {
    GWComposeToolbarButtonTypeCamera,
    GWComposeToolbarButtonTypePicture,
    GWComposeToolbarButtonTypeMention,
    GWComposeToolbarButtonTypeTrend,
    GWComposeToolbarButtonTypeEmotion
} GWComposeToolbarButtonType;

@protocol GWComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(GWComposeToolBar *)toolBar didClickedButton:(GWComposeToolbarButtonType)buttonType;

@end

@interface GWComposeToolBar : UIView

@property(nonatomic,weak) id<GWComposeToolBarDelegate> delegate;

@end
