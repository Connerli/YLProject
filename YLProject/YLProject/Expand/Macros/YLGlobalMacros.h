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
#if defined(DEBUG)|| defined(TEST)
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
//***************************屏幕的适配比例********************************
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define isIPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad: NO)
//iphoneX 系列
#define isIPhoneXAll (isIPhoneX || isIPhoneXr || isIPhoneXMax)

//屏幕大小
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
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

// 使用三基色、透明度实例化UIClor
#define rgb(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif /* YLGlobalMacros_h */
