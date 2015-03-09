//
//  GWTabBarController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWNavigationController.h"
#import "GWTabBarController.h"
#import "GWHomeViewController.h"
#import "GWMessageViewController.h"
#import "GWDiscoverViewController.h"
#import "GWMeViewController.h"
#import "UIImage+GW.h"
#import "GWTabBar.h"
#import "GWComposeViewController.h"
#import "GWUserTool.h"
#import "GWAccountTool.h"
#import "GWAccount.h"

@interface GWTabBarController ()<GWTabBarDelegate>
@property(nonatomic,weak)GWTabBar *customTabBar;

@property(nonatomic,strong)GWHomeViewController *homeVC;

@property(nonatomic,strong)GWMessageViewController *messageVC;

@property(nonatomic,strong)GWDiscoverViewController *discoverVC;

@property(nonatomic,strong)GWMeViewController *meVC;
@end

@implementation GWTabBarController

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
    
    //0.初始化tabbar
    [self setupTabBar];
    
    //1.初始化子控制器
    [self setupAllController];
    
    //2.定时检查未读数(每隔5秒钟调用一次，默认是在主线程调用)
    NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    //把定时器放到子线程，这样滚动屏幕就不会影响定时器
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)checkUnreadCount
{
    NSLog(@"checkUnreadCount------");
    //1.请求参数
    GWUserUnreadCountParam *param = [GWUserUnreadCountParam param];
    param.uid = @([GWAccountTool account].uid) ;
    
    //2.发送请求
    [GWUserTool userUnreadCountParam:param success:^(GWUserUnreadCountResult *result) {
    //3.设置badgeValue
        //3.1首页
        self.homeVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        //3.2消息
        self.messageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        //3.3我
        self.meVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
    //4.设置应用程序图标右上角的数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {//UITabBar是私有的类，不能敲出来，所以可以判断它的父类
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)setupTabBar
{
    GWTabBar *customTabBar = [[GWTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}

#pragma mark 代理方法（监听切换tabBar）
-(void)tabBar:(GWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    //如果点击首页，就刷新
    if (to == 0) {
        [self.homeVC refresh];
    }
}

#pragma mark 代理方法（监听添加微博按钮点击）
-(void)tabBarDidClickAddBtn:(GWTabBar *)tabBar
{
    GWComposeViewController *cp = [[GWComposeViewController alloc]init];
    GWNavigationController *nav = [[GWNavigationController alloc]initWithRootViewController:cp];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 初始化所有控制器
-(void)setupAllController
{
    GWHomeViewController *homeVC = [[GWHomeViewController alloc]init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.homeVC = homeVC;
    
    GWMessageViewController *messageVC = [[GWMessageViewController alloc]init];
    [self setupChildViewController:messageVC title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.messageVC = messageVC;
    
    GWDiscoverViewController *discoverVC = [[GWDiscoverViewController alloc]init];
    [self setupChildViewController:discoverVC title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discoverVC = discoverVC;
    
    GWMeViewController *meVC = [[GWMeViewController alloc]init];
    [self setupChildViewController:meVC title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.meVC = meVC;
}



#pragma mark 初始化单个控制器
-(void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVC.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageWithName:imageName];
    
    if (iOS7) {
        childVC.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVC.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    }
    
    GWNavigationController *childNav = [[GWNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:childNav];
    
    //添加tabBar内部按钮
    [self.customTabBar addTabBarBtnWithTabBarItem:childVC.tabBarItem];
}

@end
