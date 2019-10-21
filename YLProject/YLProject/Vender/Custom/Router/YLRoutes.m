//
//  YLRoutes.m
//  YLProject
//
//  Created by Conner on 2019/10/21.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLRoutes.h"

@interface YLRoutes ()
//跳转map
@property (nonatomic, strong) NSDictionary <NSString *,Class >*pushRouterMap;
//事件map
@property (nonatomic, strong) NSDictionary <NSString *,NSString *>*actionRouterMap;
@end

@implementation YLRoutes
+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Public Methods
+ (void)registDefaultRouter {
    //push 跳转相关的key
    NSArray *allPathKeys = [[YLRoutes sharedInstance].pushRouterMap allKeys];
    for (NSString *path in allPathKeys) {
        [[JLRoutes routesForScheme:APPScheme] addRoute:path handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
            NSDictionary *routerMap = [YLRoutes sharedInstance].pushRouterMap;
            Class class = routerMap[path];
            if (class) {
                UIViewController *viewController = [[class alloc] init];
                [self paramToVc:viewController param:parameters];
                [YLRouterNavigation pushViewController:viewController animated:YES];
            }
            return YES;
        }];
    }
    
    //action 事件调用
    [[JLRoutes routesForScheme:APPScheme] addRoute:@"action/:method" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        [self handleActionWithParam:parameters];
        return YES;
    }];
}

+ (BOOL)openURLWithString:(NSString *)urlString {
    if ([NSString isEmpty:urlString]) {
        return NO;
    }
    if ([urlString hasPrefix:@"http"] || [urlString hasPrefix:@"https"]) {
        //使用webView 加载
        
        return YES;
    } else {
       return  [JLRoutes routeURL:[NSURL URLWithString:urlString]];
    }
}
#pragma mark - Private Methods
//传参数
+ (void)paramToVc:(UIViewController *)vc param:(NSDictionary<NSString *,NSString *> *)parameters{
    //runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(vc.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [vc setValue:param forKey:key];
        }
    }
}
#pragma mark - RouterAction
+ (void)handleActionWithParam:(NSDictionary *)param {
    NSString *methodKey = param[@"method"];
    if ([NSString isEmpty:methodKey]) {
        NSLog(@"路由事件参数为空");
        return;
    }
    YLRoutes *routes = [YLRoutes sharedInstance];
    NSString *methodStr = routes.actionRouterMap[methodKey];
    if ([NSString isEmpty:methodStr]) {
        NSLog(@"路由未找到对应方法");
        return;
    }
    SEL method = NSSelectorFromString(methodStr);
    if ([routes respondsToSelector:method]) {
        SuppressPerformSelectorLeakWarning(
            [routes performSelector:method withObject:param];
        );
    }
}

#pragma mark - Lazy Load
- (NSDictionary<NSString *,Class> *)pushRouterMap {
    if (!_pushRouterMap) {
        _pushRouterMap = @{
               
                      };
    }
    return _pushRouterMap;
}

- (NSDictionary<NSString *,NSString *> *)actionRouterMap {
    if (!_actionRouterMap) {
        _actionRouterMap = @{
            
        };
    }
    return _actionRouterMap;
}
@end
