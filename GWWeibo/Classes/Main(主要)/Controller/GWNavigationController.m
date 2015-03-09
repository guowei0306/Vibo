//
//  GWNavigationController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-25.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWNavigationController.h"

@interface GWNavigationController ()

@end

@implementation GWNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  第一次使用这个类时候调用（就是说只会调用一次）
 */
+(void)initialize
{
    [self setupNavigationBarTheme];
    
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏主题
 */
+(void)setupNavigationBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    //2.设置标题属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[UITextAttributeTextColor] = [UIColor blackColor];
    dict[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    dict[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [navBar setTitleTextAttributes:dict];
    
}

/**
 *  设置导航栏按钮的主题
 */
+(void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disabled"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    //设置文字属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[UITextAttributeTextColor] = iOS7? [UIColor orangeColor]:[UIColor grayColor];
    dict[UITextAttributeFont] = [UIFont systemFontOfSize:iOS7 ?15:13];
    dict[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableDict = [NSMutableDictionary dictionary];
    disableDict[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
