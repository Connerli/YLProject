//
//  YLProgressHUD.m
//  YLProject
//
//  Created by Conner on 2019/5/5.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLProgressHUD.h"


@implementation YLProgressHUD
+ (void)configDefaultStyle {
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:17]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumSize:CGSizeMake(119, 104)];
    [SVProgressHUD setCornerRadius:10];
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@"app_success"] status:status];
}

+ (void)showFailWithStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@"app_fail"] status:status];
}

+ (void)showWarningWithStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@"app_notice"] status:status];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@"app_cry"] status:status];
}

+ (void)showWithStatus:(NSString*)status dismissTime:(double)times complete:(void(^)(void))complete {
    [SVProgressHUD showWithStatus:status];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(times * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [SVProgressHUD dismiss];
        if (complete) {
            complete();
        }
    });
}

+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
}

+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:maskType];
}

+ (void)showWithStatus:(NSString*)status {
    [SVProgressHUD showWithStatus:status];
}
@end
