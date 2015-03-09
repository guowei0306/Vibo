//
//  GWHomeViewController.m
//  GWWeibo
//
//  Created by 郭薇 on 14-11-24.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//


#import "GWHomeViewController.h"
#import "GWTitleButton.h"
#import "GWAccountTool.h"
#import "GWAccount.h"
#import "UIImageView+WebCache.h"
#import "GWStatus.h"
#import "GWUser.h"
#import "MJExtension.h"
#import "GWStatusFrame.h"
#import "GWStatusCell.h"
#import "MJRefresh.h"
#import "GWStatusTool.h"
#import "GWUserTool.h"

@interface GWHomeViewController ()<MJRefreshBaseViewDelegate>

@property(nonatomic,strong) NSMutableArray *statusFrames;
@property(nonatomic,strong)UIButton *titleBtn;
@property(nonatomic,weak) MJRefreshFooterView *footer;
@property(nonatomic,weak) MJRefreshHeaderView *header;
@end

@implementation GWHomeViewController

-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //0.集成系统自带刷新控件
    [self setupRefreshView];
    
    //1.设置导航栏内容
    [self setupNavBar];
    
    //2.获取用户信息
    [self setupUserDatas];
    
}

-(void)setupUserDatas
{
    //发送请求
    GWUserInfoParam *param = [GWUserInfoParam param];
    param.uid = @([GWAccountTool account].uid);
    
    [GWUserTool userInfoWithParam:(GWUserInfoParam *)param success:^(GWUserInfoResult *result) {
        [self.titleBtn setTitle:result.name forState:UIControlStateNormal];
        //保存昵称
        GWAccount *account = [GWAccountTool account];
        account.name = result.name;
        [GWAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupRefreshView
{
    //1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    self.header = header;
    
    //2.上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

/**
 *  代理方法：刷新控件进入开始刷新时候调用
 *
 *  @param refreshView
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreDatas];
    }else{
        [self loadNewDatas];
    }
    
}

-(void)loadMoreDatas
{
    //发送请求
    GWHomeStatusesParam *param = [[GWHomeStatusesParam alloc]init];
    param.count = @(5);
    
    if (self.statusFrames.count) {
        GWStatusFrame *statusFrame = [self.statusFrames lastObject];
        //加载比max_id的ID小的微博
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    [GWStatusTool homeStatusWithParam:param success:^(GWHomeStatusesResult *result) {
        //将字典数组转为模型数组
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (GWStatus *status in result.statuses) {
            GWStatusFrame *statusFrame = [[GWStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //添加新数据到旧数据最后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        //刷新表格
        [self.tableView reloadData];
        //停止刷新
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        //停止刷新
        [self.footer endRefreshing];
    }];
}



-(void)loadNewDatas
{
    //0.badgeValue参数
//    self.tabBarItem.badgeValue = nil;
    
    //封装参数
    GWHomeStatusesParam *param = [[GWHomeStatusesParam alloc]init];
    param.count = @(20);
    
    if (self.statusFrames.count) {
        GWStatusFrame *statusFrame = self.statusFrames[0];
        //加载比since_id的ID大的微博
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    [GWStatusTool homeStatusWithParam:param success:^(GWHomeStatusesResult *result) {
        //将字典数组转为模型数组
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (GWStatus *status in result.statuses) {
            GWStatusFrame *statusFrame = [[GWStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //创建临时可变数据
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        //刷新表格
        [self.tableView reloadData];
        //让刷新的菊花消失
        [self.header endRefreshing];
        
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        //让刷新的菊花消失
        [self.header endRefreshing];
    }];
}


-(void)showNewStatusCount:(int)count
{
    //创建按钮
    UIButton *btn = [[UIButton alloc]init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //禁止点击，设置背景
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizeImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //按钮title
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新的微博" forState:UIControlStateNormal];
    }
    
    //按钮的frame
    CGFloat btnX = 5;
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width - 2 *btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //通过动画移动按钮（向下移动）
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnY + 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

-(void)dealloc
{
    [self.header free];
    [self.footer free];
}


/**
 *  设置导航栏
 */
-(void)setupNavBar
{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" action:@selector(findFriend) target:self];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" action:@selector(pop) target:self];
    //中间按钮
    GWTitleButton *titleBtn = [GWTitleButton titleButton];
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    //位置和尺寸
    titleBtn.frame = CGRectMake(0, 0, 0, 40);
    
    GWAccount *account = [GWAccountTool account];
    if (account.name) {
        //设置文字
        [titleBtn setTitle:account.name forState:UIControlStateNormal];
    }else{
        //设置文字
        [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    
    
    //添加监听
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = titleBtn;
    
    self.navigationItem.titleView = titleBtn;
    
    self.tableView.backgroundColor  = GWColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GWStatusTableBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)titleClick:(GWTitleButton *)titleButton
{
    if (titleButton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_down"]) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }else{
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
        
   
}

-(void)findFriend
{
    GWLog(@"findFriend---");
}

-(void)pop
{
    GWLog(@"pop----");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

#pragma mark 每一行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    GWStatusCell *cell = [GWStatusCell cellWithTableView:tableView];
    
    //传递模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc  = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor blueColor];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refresh
{
    if ([self.tabBarItem.badgeValue intValue]!= 0) {
        [self.header beginRefreshing];
    }
}

@end
