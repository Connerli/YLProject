//
//  YLRoutes.h
//  YLProject
//
//  Created by Conner on 2019/10/21.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <JLRoutes.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLRoutes : JLRoutes
///单例
+ (instancetype)sharedInstance;
/**
 注册默认router
 */
+ (void)registDefaultRouter;

/**
 跳转链接
 @param urlString 路径地址
 */
+ (BOOL)openURLWithString:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
