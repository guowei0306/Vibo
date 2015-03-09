//
//  GWOAuthViewController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//

#import "GWOAuthViewController.h"
#import "GWAccount.h"
#import "GWWeiboTool.h"
#import "GWAccountTool.h"
#import "GWHttpTool.h"

@interface GWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation GWOAuthViewController

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
    //添加
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    //加载授权页面
    NSURL *url = [NSURL URLWithString:GWLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

/**
 *  主动或者被动发送请求之前都会调用这个方法
 *
 *  @return YES/NO
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //请求的url绝对路径
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        //截取code=后面的(请求标记，经过用户授权成功)
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        //发送POST请求给新浪，通过code换取request token（访问标记）
        [self accessTokenWithCode:code];
        //不加载这个请求，不回先跳转到回调页面
        return NO;
    }
    return YES;
}

/**
 *  webview开始发送请求时调用
 */
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示提醒框
    [MBProgressHUD showMessage:@"哥正在帮你加载中"];
}

/**
 *  webview加载完毕时调用
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏提醒框
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //隐藏提醒框
    [MBProgressHUD hideHUD];
}

-(void)accessTokenWithCode:(NSString *)code
{
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = GWAppKey;
    params[@"client_secret"] = GWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = GWRedirectUri;
    
    [GWHttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        //存储授权数据
        //字典转模型
        GWAccount *account = [GWAccount accountWithDict:json];
        //存储
        [GWAccountTool saveAccount:account];
        //登陆成功：新特性\首页
        [GWWeiboTool chooseRootViewController];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
}


@end
