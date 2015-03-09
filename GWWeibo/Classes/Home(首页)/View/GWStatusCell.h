//
//  GWStatusCell.h
//  GWWeibo
//
//  Created by 郭薇 on 14-11-26.
//  Copyright (c) 2014年 郭薇. All rights reserved.
//  首页status的cell

#import <UIKit/UIKit.h>
@class  GWStatusFrame;

@interface GWStatusCell : UITableViewCell

@property(nonatomic,strong)GWStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
