//
//  GWComposeViewController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-12-4.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//
/**
 *  UITextField不能换行,UITextView不能提示文字。只能自定义
 */

#import "GWComposeViewController.h"
#import "GWTextView.h"
#import "GWAccountTool.h"
#import "GWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "GWComposeToolBar.h"
#import "GWComposePhotosView.h"
#import "GWStatusTool.h"

@interface GWComposeViewController ()<UITextViewDelegate,GWComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,weak)GWTextView *textView;
@property(nonatomic,weak)GWComposeToolBar *toolBar;
@property(nonatomic,weak)GWComposePhotosView *photosView;

@end

@implementation GWComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏属性
    [self setupNavBar];
    
    //添加textview
    [self setupTextView];
    
    //添加工具条
    [self setupToolBar];
    
    //添加图片view
    [self setupPhotosView];
}

-(void)setupPhotosView
{
    GWComposePhotosView *photosView = [[GWComposePhotosView alloc]init];
    CGFloat photoW = self.view.frame.size.width;
    CGFloat photoY = 80;
    CGFloat photoH = self.view.frame.size.height;
    photosView.frame = CGRectMake(0, photoY, photoW, photoH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

-(void)setupToolBar
{
    GWComposeToolBar *toolBar = [[GWComposeToolBar alloc]init];
    CGFloat toolBarH = 44;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    [self.view addSubview:toolBar];
    toolBar.delegate = self;
    self.toolBar = toolBar;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

-(void)setupTextView
{
    //1.添加
    GWTextView *textView = [[GWTextView alloc]init];
    [textView setFont:[UIFont systemFontOfSize:15]];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
    //垂直方向永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    //2.监听文字改变的通知
    [GWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //3.监听键盘通知
    [GWNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [GWNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)note
{
    //1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //2.取出键盘弹出世间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

-(void)keyboardWillHide:(NSNotification *)note
{
    
    //1.取出键盘弹出世间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);

}

-(void)dealloc
{
    [GWNotificationCenter removeObserver:self];
}

-(void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    if (self.photosView.totalImages.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    //关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendWithImage
{
    //1.封装普通参数
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [GWAccountTool account].access_token;
    
    //2.封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *photos = self.photosView.totalImages;
//    for (UIImage *image in photos) {
//        GWFormData *formData = [[GWFormData alloc]init];
//        formData.data = UIImageJPEGRepresentation(image, 1.0);
//        formData.name = @"pic";
//        formData.filename = @"";
//        formData.mimeType = @"image/jpeg";
//        [formDataArray addObject:formData];
//    }
//    
//    [GWHttpTool postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    
}

-(void)sendWithoutImage
{
    
    //发送请求
    
    GWSendStatusParam *param = [GWSendStatusParam param];
    param.status = self.textView.text;;
    param.access_token = [GWAccountTool account].access_token;
    
    [GWStatusTool sendStatusWithParam:param success:^(GWSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
//    [GWHttpTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)composeToolBar:(GWComposeToolBar *)toolBar didClickedButton:(GWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case GWComposeToolbarButtonTypeCamera://相机
            [self openCamera];
            break;
        case GWComposeToolbarButtonTypePicture: //相册
            [self openPictureLibrary];
            break;
        case GWComposeToolbarButtonTypeEmotion://表情
            
            break;
        case GWComposeToolbarButtonTypeMention://艾特
            
            break;
        case GWComposeToolbarButtonTypeTrend: //话题
            
            break;
        default:
            return;
            break;
    }
}

/**
 *  打开系统相机
 */
-(void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开系统相册
 */
-(void)openPictureLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  选择图片（不用判断图片来源）
 *
 *  @param picker 图片选择器，相册/相机
 *  @param info   图片信息
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.退出图片选择器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //2.取出图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

@end
