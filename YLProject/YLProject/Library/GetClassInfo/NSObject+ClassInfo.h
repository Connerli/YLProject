//
//  NSObject+ClassInfo.h
//  PersonalProjects
//
//  Created by Conner on 2017/9/25.
//  Copyright © 2017年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ClassInfo)
//获得所有变量
+ (NSArray *)getAllIvar:(id)object;
//获得所有属性
+ (NSArray *)getAllProperty:(id)object;
@end
