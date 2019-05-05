//
//  YLNetworkConfig.h
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLNetworkConfig : NSObject
/** 网路配置单例 */
+ (instancetype)sharedInstance;
/** 配置网络主要配置验证证书策略 */
- (void)configNetwork;
/** 开启网络监听 */
- (void)startMonitoring;
/** 全局参数，比如AppVersion, ApiVersion等 */
+ (NSDictionary *)globalParameters;
/** 手机型号 信息 */
+ (NSString *)mobileModel;
/**
 将请求的数据转成 get url 链接
 @param baseUrl 主域名
 @param requestUrl 请求地址
 @param parameters 参数
 @return 拼接后的地址
 */
+ (NSString *)URLStringWithBaseUrl:(NSString *)baseUrl requestUrl:(NSString *)requestUrl parameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
