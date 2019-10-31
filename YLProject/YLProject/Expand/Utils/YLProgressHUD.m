//
//  YLProgressHUD.m
//  YLProject
//
//  Created by Conner on 2019/5/5.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLProgressHUD.h"


@implementation YLProgressHUD

+ (void)load {
    [self configDefaultStyle];
}

+ (void)configDefaultStyle {
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
     [SVProgressHUD setMinimumDismissTimeInterval:1];
     [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:17]];
     [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
     [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
     [SVProgressHUD setMinimumSize:CGSizeMake(100, 30)];
     [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
     [SVProgressHUD setCornerRadius:10];
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showTipWithMessage:(NSString *)message {
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:message];
    [self dismissDefaultDelay];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [SVProgressHUD showSuccessWithStatus:status];
    [self dismissDefaultDelay];
}

+ (void)showFailWithStatus:(NSString *)status {
    [SVProgressHUD showErrorWithStatus:status];
    [self dismissDefaultDelay];
}

+ (void)showWarningWithStatus:(NSString *)status {
    [SVProgressHUD showInfoWithStatus:status];
    [self dismissDefaultDelay];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [SVProgressHUD showErrorWithStatus:status];
    [self dismissDefaultDelay];
}

+ (void)showWithStatus:(NSString*)status {
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString *)status dismissTime:(double)times {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD dismissWithDelay:times];
}

+ (void)showWithStatus:(NSString*)status dismissTime:(double)times complete:(void(^)(void))complete {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD dismissWithDelay:times completion:complete];
}

+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
}

+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:maskType];
}


+ (void)dismissDefaultDelay {
    [SVProgressHUD dismissWithDelay:2];
}
@end
