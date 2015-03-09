//
//  GWNewfeatureViewController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-25.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#define GWNewfeatureImageCount 3
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

#import "GWNewfeatureViewController.h"
#import "GWTabBarController.h"

@interface GWNewfeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageControl;
@end

@implementation GWNewfeatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = GWColor(246, 246, 246);
    [self setupScrollView];
    [self setupPageControl];
}

-(void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int i =0; i<GWNewfeatureImageCount; i++) {
        NSString *name = nil;
        if (fourInch) {
            name = [NSString stringWithFormat:@"new_feature_%d-568h",i + 1];
        }else{
            name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        }
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:name]];
        //设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        //在最后一个imageView上面添加按钮
        if (i == GWNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    [self.view addSubview:scrollView];
    //设置滚动内容范围
    scrollView.contentSize = CGSizeMake(imageW * GWNewfeatureImageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
}

-(void)setupLastImageView:(UIImageView *)imageView
{
    //0.让imageView可以与用户交互
    imageView.userInteractionEnabled = YES;
    
    //1.添加开始按钮
    UIButton *startButton = [[UIButton alloc]init];
    //设置按钮背景
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero,startButton.currentBackgroundImage.size};
    
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    //2.添加分享checkBox
    UIButton *shareButton = [[UIButton alloc]init];
    //frame
    CGFloat shareCenterX = centerX;
    CGFloat shareCenterY = self.view.frame.size.height * 0.5;
    shareButton.center = CGPointMake(shareCenterX, shareCenterY);
    shareButton.bounds = startButton.bounds;
    
    //图片、标题设置(默认选中分享)
    shareButton.selected = YES;
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    //监听点击
    [shareButton addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
}

-(void)checkBoxClick:(UIButton *)checkBox
{
    checkBox.selected = !checkBox.selected;
}

-(void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //分页数
    pageControl.numberOfPages = GWNewfeatureImageCount;
    //位置
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.currentPageIndicatorTintColor = GWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = GWColor(189, 189, 189);
    [self.view addSubview:pageControl];
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    _pageControl = pageControl;

}

#pragma mark 监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageCount = scrollView.contentOffset.x / scrollView.frame.size.width;
    int page = floor(pageCount + 0.5);
    _pageControl.currentPage = page;
}

-(void)start
{
    [UIApplication sharedApplication].statusBarHidden = NO;
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[GWTabBarController alloc]init];
    self.view.window.rootViewController = [[GWTabBarController alloc]init];
}

-(void)dealloc
{
    GWLog(@"dealloc---");
}

@end
