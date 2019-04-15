//
//  NSString+YLAdditions.h
//  PersonalProject
//
//  Created by conner on 2019/1/29.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YLAdditions)
/** 检测是否是空字符串(去除空字符后) */
+ (BOOL)isEmpty:(NSString *)string;
@end

NS_ASSUME_NONNULL_END