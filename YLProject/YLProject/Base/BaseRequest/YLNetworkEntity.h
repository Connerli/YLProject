//
//  YLNetworkEntity.h
//  YLProject
//
//  Created by Conner on 2019/5/5.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLNetworkEntity : NSObject
/** 后端定义code码 */
@property(nonatomic, copy) NSString *code;

/** 后端定义描述 */
@property(nonatomic, copy) NSString *msg;

// 数据
@property(nonatomic, strong) id data;

@end

NS_ASSUME_NONNULL_END
