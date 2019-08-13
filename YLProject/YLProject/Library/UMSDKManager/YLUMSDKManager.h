//
//  YLUMSDKManager.h
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLUMSDKManager : NSObject
+ (instancetype)sharedInstance;

/**
 初始化友盟推送信息  统计 分享 推送
 
 @param launchOptions 启动信息
 */
- (void)configUMSdk:(NSDictionary *)launchOptions;


/**
 收到推送消息
 
 @param userInfo 用户信息
 */
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/**
 添加用户标签和别名
 */
+ (void)addUserTagsAndAlias;

/**
 移除用户标签和别名
 */
+ (void)removeUserTagsAndAlias;

@end

NS_ASSUME_NONNULL_END
