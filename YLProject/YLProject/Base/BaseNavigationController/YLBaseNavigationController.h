//
//  YLBaseNavigationController.h
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBaseNavigationController : UINavigationController

/// 自定义导航栏返回按钮事件
+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
