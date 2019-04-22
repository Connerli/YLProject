//
//  CYBaseTableView.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 HuaLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYBaseTableView;
NS_ASSUME_NONNULL_BEGIN

typedef void (^TableViewStartRefreshBlock)(CYBaseTableView *tableView);
typedef void (^TableViewStartLoadMoreBlock)(CYBaseTableView *tableView);

@interface CYBaseTableView : UITableView
/// 下拉刷新回调
@property (copy, nonatomic) TableViewStartRefreshBlock startRefreshBlock;
/// 加载更多回调
@property (copy, nonatomic) TableViewStartLoadMoreBlock startLoadMoreBlock;

/// 是否自动调整contentInset Default:NO
@property (nonatomic, assign) BOOL isAdjustContentInset;

/**
 显示下拉刷新的动画, 并调用 startRefreshBlock
 */
- (void)autoLoadingWithAnimation;

/**
 结束所有刷新 并显示 没有更多数据的视图
 
 @param success 刷新是否成功, 作用待定
 */
- (void)endRefreshSuccess:(BOOL)success;

/**
 加载更多成功
 
 @param success 刷新是否成功, 作用待定
 */
- (void)endLoadMoreSuccess:(BOOL)success;


/**
 加载更多结束, 且没有更多数据
 */
- (void)endLoadMoreNoMoreData;


/**
 调用数据源方法, 获取是否有cell需要显示
 
 @return 只有有一个cell就返回YES
 */
- (BOOL)isHaveData;
@end

NS_ASSUME_NONNULL_END
