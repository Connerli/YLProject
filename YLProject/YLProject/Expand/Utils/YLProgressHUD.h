//
//  YLProgressHUD.h
//  YLProject
//
//  Created by Conner on 2019/5/5.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN

@interface YLProgressHUD : NSObject
/**
 配置ProgressHUD 默认样式
 */
+ (void)configDefaultStyle;

/**
 *  显示可交互HUD
 */
+ (void)show;

/**
 *  隐藏HUD
 */
+ (void)dismiss;
/**
 显示提示语 默认两秒
 
 @param message 提示信息
 */
+ (void)showTipWithMessage:(NSString *)message;
/**
 显示成功HUD
 
 @param status 提示语
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 显示失败HUD
 
 @param status 提示语
 */
+ (void)showFailWithStatus:(NSString *)status;

/**
 显示错误HUD
 
 @param status 提示语
 */
+ (void)showErrorWithStatus:(NSString *)status;

/**
 显示警告HUD
 
 @param status 提示语
 */
+ (void)showWarningWithStatus:(NSString *)status;

/**
 *  显示文本HUD 带进度条
 */
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString *)status dismissTime:(double)times;
+ (void)showWithStatus:(NSString*)status dismissTime:(double)times complete:(void(^)(void))complete;
@end

NS_ASSUME_NONNULL_END
