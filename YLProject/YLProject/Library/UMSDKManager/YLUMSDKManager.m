//
//  YLUMSDKManager.m
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLUMSDKManager.h"
#import <UMCommon/UMCommon.h>
#import <UmCommon/UMConfigure.h>
#import <UMPush/UMessage.h>
#import <UMShare/UMShare.h>
#import <UMAnalytics/MobClick.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UserNotifications/UserNotifications.h>

#define k_umeng_appkey  @""
#define k_weixin_appkey @""
#define k_weixin_secret @""
#define k_qq_appkey     @""
#define k_qq_secret     @""
#define k_sina_appkey   @""
#define k_sina_sectet   @""
#define k_redirectURL   @"http://mobile.umeng.com/social" // 各个app一样的,申请的时候填写
#define k_sina_redirectURL @"http://sns.whalecloud.com/sina2/callback" //

@interface YLUMSDKManager ()<UNUserNotificationCenterDelegate>

@end

@implementation YLUMSDKManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Public Methods
- (void)configUMSdk:(NSDictionary *)launchOptions {
    [UMConfigure initWithAppkey:k_umeng_appkey channel:nil];
    // 分享
    [self handleUMSocial];
    
    // 统计
    [self handleUMAnalytics];
    
    // 推送
    [self handleUMMessage:launchOptions];
    
}

+ (void)addUserTagsAndAlias {

}

+ (void)removeUserTagsAndAlias {
 
}

#pragma mark - Private
- (void)handleUMSocial {
    if (![NSString isEmpty:k_weixin_appkey]) {
        // wechat
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:k_weixin_appkey appSecret:k_weixin_secret redirectURL:k_redirectURL];
    }
    
    if (![NSString isEmpty:k_qq_appkey]) {
        // qq
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:k_qq_appkey appSecret:k_qq_secret redirectURL:k_redirectURL];
    }
    if (![NSString isEmpty:k_sina_appkey]) {
        // sina
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:k_sina_appkey appSecret:k_sina_sectet redirectURL:k_sina_redirectURL];
    }
}

- (void)handleUMAnalytics {
#if defined(DEBUG)||defined(TEST)
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
#endif
    
    [MobClick setScenarioType:E_UM_NORMAL];
}

- (void)handleUMMessage:(NSDictionary *)launchOptions {
    // 不显示sdk push 弹框
    [UMessage setAutoAlert:NO];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    
    // type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        } else {
            
        }
    }];
}

#pragma mark - 注册推送
/// iOS 10 之前收到推送消息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self handleForegroundPushEvent:userInfo];
    } else {
        [self handleBackgroundPushEvent:userInfo];
    }
    
    [UMessage didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

/// iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            [self handleForegroundPushEvent:userInfo];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于前台时的本地推送接受(目前没有创建本地推送)
            
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(UNNotificationPresentationOptionBadge);
}

/// iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受
            [self handleBackgroundPushEvent:userInfo];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于后台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - 处理推送消息
/// 处理前台推送消息
- (void)handleForegroundPushEvent:(NSDictionary *)userInfo {
 
    
}

/// 处理后台点击推送
- (void)handleBackgroundPushEvent:(NSDictionary *)userInfo {
    
}

@end
