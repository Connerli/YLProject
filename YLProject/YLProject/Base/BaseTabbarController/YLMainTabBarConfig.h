//
//  YLMainTabBarConfig.h
//  YLProject
//
//  Created by Conner on 2019/8/31.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLMainTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLMainTabBarConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) YLMainTabBarController *tabBarController;
@end

NS_ASSUME_NONNULL_END
