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
 *  显示文本HUD
 */
+ (void)showWithStatus:(NSString*)status dismissTime:(double)times complete:(void(^)(void))complete;
+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)status;
@end

NS_ASSUME_NONNULL_END
