//
//  YLAPPInfoTool.h
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAPPInfoTool : NSObject
/**
 获取应用名
 @return 应用名
 */
+ (NSString *)appDisplayName;
/**
 获取应用版本号
 @return 版本号
 */
+ (NSString *)appVersion;

/**
 获取应用build 版本
 @return build 版本
 */
+ (NSString *)appBuildNumber;

/**
 ipa 构建时间
 @return 时间
 */
+ (NSString *)ipaBuildTime;

/// 手机系统版本
+ (NSString *)systemVersion;
@end

NS_ASSUME_NONNULL_END
