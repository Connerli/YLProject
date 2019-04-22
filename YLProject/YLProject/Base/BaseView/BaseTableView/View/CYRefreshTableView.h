//
//  CYRefreshTableView.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 HuaLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBaseTableView.h"
#import "UIScrollView+CYBlankPage.h"
@class CYBaseCellModel;
@class CYBaseTableView;
@class CYRefreshTableView;
NS_ASSUME_NONNULL_BEGIN

@protocol CYTableViewDelegate <NSObject, UITableViewDelegate>
@optional
- (void)tableView:(CYBaseTableView *)tableView didSelectObject:(CYBaseCellModel *)object atIndexPath:(NSIndexPath*)indexPath;
@end



@interface CYRefreshTableView : UIView
/// 必须设值,即便是nil. delegate 可以获取 <LDBaseTableViewDelegate,UITableViewDelegate,UITableViewDataSource>的所有方法回调
@property (nonatomic ,weak) id<CYTableViewDelegate> delegate;

/// 公开内部tableView 为了属性设置使用 ps：尽量使用下面的属性和方法不直接设置tableView
@property (nonatomic ,strong) CYBaseTableView *tableView;

/// 二维数组 一维度为分区 二维度为分区元素个数 如果只有一个数组列表则为一维度数组，内部处理了
/// 赋值后自动调用 reloadData
@property (nonatomic ,copy) NSArray *items;

/// 每个分区元素个数 内部会将一维度的items 重新按照 sectionMembersCount 分割成二维数组 如果items本为二维数组则设置该值无效
@property (nonatomic, assign) NSInteger sectionMembersCount;

/// tableView 分割线 默认为 UITableViewCellSeparatorStyleNone
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;
/// 头部view
@property (nonatomic, strong) UIView *tableHeaderView;
/// 尾部View
@property (nonatomic, strong) UIView *tableFooterView;

/// 下拉刷新回调
@property (strong, nonatomic) TableViewStartRefreshBlock startRefreshBlock;
/// 加载更多回调
@property (strong, nonatomic) TableViewStartLoadMoreBlock startLoadMoreBlock;

/// 是否自动调整contentInset Default:NO
@property (nonatomic, assign) BOOL isAdjustContentInset;

/**
 指定初始化方法
 
 @param frame frame
 @param style style
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

/**
 返回对应indexPath位置的item
 
 @param indexPath 对应位置
 @return item
 */
- (__kindof CYBaseCellModel*)objectForRowAtIndexPath:(NSIndexPath*)indexPath;

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
 显示空白页图
 */
- (void)showPlaceImageWithType:(PlaceImageType)type;
- (void)showPlaceImageWithType:(PlaceImageType)type contentOffset:(CGPoint)offset;
//隐藏占位图
- (void)hidePlaceImageView;
//刷新数据
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
