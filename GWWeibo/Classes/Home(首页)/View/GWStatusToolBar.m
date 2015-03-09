//
//  GWStatusToolBar.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-28.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWStatusToolBar.h"
#import "GWStatus.h"


@interface GWStatusToolBar ()

@property(nonatomic,strong)NSMutableArray *dividers;

@property(nonatomic,strong)NSMutableArray *buttons;

@property(nonatomic,weak) UIButton *retweetBtn;

@property(nonatomic,weak) UIButton *commentBtn;

@property(nonatomic,weak) UIButton *unlikeBtn;

@end


@implementation GWStatusToolBar


-(NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

-(NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //设置图片
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        //添加按钮
        //转发
        self.retweetBtn = [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        //评论
        self.commentBtn = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        //赞
        self.unlikeBtn = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        [self setupDivider];
        
        [self setupDivider];
    }
    return self;
}

-(void)setupDivider
{
    //添加分割线
    UIImageView *divider = [[UIImageView alloc]init];
    [divider setImage:[UIImage imageWithName:@"timeline_card_bottom_line"]];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 *
 *  @param title   标题
 *  @param image   图标
 *  @param bgImage 背景图
 */
-(UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:button];
    [self.buttons addObject:button];
    return button;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int btnCount = self.buttons.count;
    int divCount = self.dividers.count;
    CGFloat divW = 2;
    CGFloat divH = self.frame.size.height;
    CGFloat divY = 0;
    
    CGFloat btnH = divH;
    CGFloat btnY = 0;
    CGFloat btnW = (self.frame.size.width - divCount * divW) / btnCount;
    
    
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = (btnW + divW) * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    

    for (int j = 0; j < divCount; j++) {
        UIImageView  *div = self.dividers[j];
        UIButton *button = self.buttons[j];
        CGFloat divX = CGRectGetMaxX(button.frame);
        div.frame = CGRectMake(divX, divY, divW, divH);
    }
    

}

-(void)setStatus:(GWStatus *)status
{
    _status = status;
    
    [self btnNumberWithBtn:self.retweetBtn OriginalTitle:@"转发" count:status.reposts_count];
    [self btnNumberWithBtn:self.commentBtn OriginalTitle:@"评论" count:status.comments_count];
    [self btnNumberWithBtn:self.unlikeBtn OriginalTitle:@"赞" count:status.attitudes_count];
    
}

/**
 *  设置按钮显示的标题
 *
 *  @param btn           按钮
 *  @param originalTitle 默认显示标题（count为0）
 *  @param count         显示个数
 */
-(void)btnNumberWithBtn:(UIButton *)btn OriginalTitle:(NSString *)originalTitle count:(int)count
{
    if (count == 0) {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }else if(count < 10000){
        NSString *title = [NSString stringWithFormat:@"%d",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else {
        double countDouble = count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万",countDouble];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
