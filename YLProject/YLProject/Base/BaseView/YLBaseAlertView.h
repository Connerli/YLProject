//
//  YLBaseAlertView.h
//  PersonalProjects
//
//  Created by Conner on 2018/6/25.
//  Copyright © 2018年 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

//位置
typedef  NS_ENUM(NSInteger,AlertContentMode) {
    AlertContentModeCenter = 0, //位置默认中心
    AlertContentModeBottom,     //底部
};

//动画
typedef NS_ENUM(NSInteger,AlertViewAnimation) {
    AlertViewAnimationDefault,
};

@interface YLBaseAlertView : UIView

//当前视图是否在显示
@property (nonatomic, assign,getter=isShow,readonly) BOOL show;
//默认内容样式居中
@property (nonatomic, assign) AlertContentMode contentMode;
//显示动画
@property (nonatomic, assign) AlertViewAnimation showAnimation;
//隐藏动画
@property (nonatomic, assign) AlertViewAnimation hiddenAnimation;
/**
 显示弹框 keywindow
 */
- (void)showInKeyWindow;
/**
 弹出弹框
 @param view 添加的view
 */
- (void)showInView:(UIView *)view;
/**
 消失
 */
- (void)dismiss;

@end
