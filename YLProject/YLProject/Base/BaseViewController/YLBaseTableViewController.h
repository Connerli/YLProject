//
//  YLBaseTableViewController.h
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBaseViewController.h"
#import "YLRefreshTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLBaseTableViewController : YLBaseViewController<YLTableViewDelegate>
//tableView 载体
@property (nonatomic, strong) YLRefreshTableView *refreshView;
//是否自定义layout default NO
@property (nonatomic, assign,getter=isCustomLayout) BOOL customLayout;
//自定义tableView 内容填充范围 默认是填充整个View
@property (nonatomic, assign) UIEdgeInsets insets;
@end

NS_ASSUME_NONNULL_END
