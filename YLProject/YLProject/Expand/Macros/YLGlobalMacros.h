//
//  YLGlobalMacros.h
//  PersonalProjects
//
//  Created by Conner on 2018/5/18.
//  Copyright © 2018年 Conner. All rights reserved.
//

#ifndef YLGlobalMacros_h
#define YLGlobalMacros_h
/*************  Log  ****************/
#ifdef DEBUG
#define NSLog(format, ...) do {                                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
#else
#define NSLog(...)
#endif
//*************方便弱引用类型的声明与赋值&方便强引用类型的声明与赋值 ****************/
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else

#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
/*****************根据屏幕分辨率判断设备类型**********/
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
//屏幕大小
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define iPhone4Size                 CGSizeMake(640.f / 2.f, 960.f / 2.f)
#define iPhone5Size                 CGSizeMake(640.f / 2.f, 1136.f / 2.f)
#define iPhone6Size                 CGSizeMake(750.f / 2.f, 1334.f / 2.f)
#define iPhone6pSize                CGSizeMake(1242.f / 3.f, 2208.f / 3.f)
#define iPhoneXSize                 CGSizeMake(1125.f / 3.f, 2436.f / 3.f)
//iphone6 为基础设备 屏幕适配
#define DefaultDeviceSize       iPhone6Size
#define ALLineHeight(...)       ((__VA_ARGS__) / AL_SCREEN_SCALE)
#define ALRectWidth(...)        ((__VA_ARGS__) * AL_SCREEN_WIDTH / DefaultDeviceSize.width)
#define ALRectHeight(...)       ((__VA_ARGS__) * AL_SCREEN_HEIGHT / DefaultDeviceSize.height)
//字体适配
#define ALFont(s)               [UIFont systemFontOfSize:(s) * AL_SCREEN_WIDTH / DefaultDeviceSize.width]
#define ALBoldFont(s)           [UIFont boldSystemFontOfSize:(s) * AL_SCREEN_WIDTH / DefaultDeviceSize.width]
//国际化本地字符串
#define ALLocalizedString(str)  NSLocalizedString(str, nil)
//单独线高度
#define SINGLE_LINE_HIGHT  (1.0 / [UIScreen mainScreen].scale)
#endif /* YLGlobalMacros_h */
