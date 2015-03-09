//0.账号相关的信息
#define GWAppKey @"2641973152"
#define GWAppSecret @"0fd1869a45c945eb82c4a87ed7eb2f7b"
#define GWRedirectUri @"www.baidu.com"

#define GWLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",GWAppKey,GWRedirectUri]


//1.判断是否iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0 )

//2.判断是否四英寸
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

//3.自定义Log
#ifdef DEBUG
#define GWLog(...) NSLog(__VA_ARGS__)
#else
#define GWLog(...)
#endif

//4.获得RGB颜色
#define GWColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//5.设置微博cell的属性
/** cell内部间距*/
#define GWStatusCellBorder 10
/** 原创微博 昵称 文字*/
#define GWStatusNameFont [UIFont systemFontOfSize:15]
/** 原创微博 正文 文字*/
#define GWStatusContentFont [UIFont systemFontOfSize:13]
/** 原创微博 时间 文字*/
#define GWStatusTimeFont [UIFont systemFontOfSize:12]
/** 原创微博 来源 文字*/
#define GWStatusSourceFont GWStatusTimeFont
/** 表格边框宽度*/
#define GWStatusTableBorder 5
/** 转发微博 昵称 文字*/
#define GWRetWeetStatusNameFont [UIFont systemFontOfSize:14]
/** 转发微博 正文 文字*/
#define GWRetWeetStatusContentFont GWStatusContentFont

//6.设置微博cell内部的相册
#define GWPhotoW 70
#define GWPhotoH 70
#define GWPhotoMargin 10


//7.常用的对象
#define GWNotificationCenter [NSNotificationCenter defaultCenter]