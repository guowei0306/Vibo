//
//  GWTextView.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-4.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWTextView.h"

@interface GWTextView ()
@property(nonatomic,weak)UILabel *placeholderLabel;

@end
@implementation GWTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加提示文字
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = NO;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font = self.font;
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;
        //2.监听通知
        [GWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)textDidChange
{
    self.placeholderLabel.hidden = self.text.length;
}

-(void)dealloc
{
    [GWNotificationCenter removeObserver:self];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        CGFloat placeX = 5;
        CGFloat placeY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeX;
        CGFloat maxH = self.frame.size.height - 2 *placeY;
        CGSize placeholderSize =  [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = (CGRect){{placeX,placeY},placeholderSize};
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

@end
