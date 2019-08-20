//
//  YLBaseCell.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YLBaseCellModel;
@interface YLBaseCell : UITableViewCell
//数据
@property (nonatomic, strong) YLBaseCellModel *model;
//坐标
@property (nonatomic, strong) NSIndexPath *indexPath;
//代理
@property (nonatomic, weak) id delegate;

/**
 cell高度
 @param tableView tableView
 @param model 数据
 @return 高度
 */
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(YLBaseCellModel *)model;

/**
 配置初始化
 */
- (void)configInit;
@end

NS_ASSUME_NONNULL_END
