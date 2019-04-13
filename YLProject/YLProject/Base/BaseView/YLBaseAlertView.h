//
//  YLBaseAlertView.h
//  PersonalProjects
//
//  Created by Conner on 2018/6/25.
//  Copyright © 2018年 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,AlertContentMode) {
    AlertContentModeCenter = 0, //位置默认中心
    AlertContentModeBottom,     //底部
};

@interface YLBaseAlertView : UIView
//TIP: 弹框默认是居中展示的，如果需要自己调整位置，子类重写下面方法，修改位置
//当前视图是否在显示
@property (nonatomic, assign,getter=isShow,readonly) BOOL show;
//默认内容样式居中
@property (nonatomic, assign)  AlertContentMode contentMode;
/**
 显示弹框 keywindow
 @param animated 动画（暂时没加）
 */
- (void)showInKeyWindowWithAnimated:(BOOL)animated;
/**
 隐藏弹框 keywindow
 @param animated 动画（暂时没加）
 */
- (void)hiddenFromKeyWindowWithAnimated:(BOOL)animated;
/**
 弹出弹框
 @param view 添加的view
 @param animated 动画效果（暂时没加）
 */
- (void)showInView:(UIView *)view animated:(BOOL)animated;
/**
 隐藏弹框
 @param view 隐藏的View
 @param animated 动画效果（暂时没有添加）
 */
- (void)hiddenFromView:(UIView *)view animated:(BOOL)animated;
//隐藏视图
- (void)hiddenFromSupperView;
//点击了背景图
- (void)didClickMaskView;
@end
