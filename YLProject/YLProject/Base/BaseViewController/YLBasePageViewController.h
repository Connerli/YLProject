//
//  YLBasePageViewController.h
//  YLProject
//
//  Created by Conner on 2019/4/25.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "WMPageController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YLPageMenuStyle) {
    YLPageMenuStyleDefault   = 0,     // 默认样式
};
/** Tips
 该协议主要为统一返回数据方法，如果不满足自己的需求可以重写 WMPageController 代理方法
 实现自己想要的功能,在该方法内扩展
 */
@protocol YLBasePageControllerDataSource <NSObject>
@optional
/** menuView frame*/
- (CGRect)pageMenuViewFrame;
/** contentView frame*/
- (CGRect)pageContentViewFrame;
/** 控制器 */
- (UIViewController *)pageControllerWithIndex:(NSInteger)index;
/** 标题 */
- (NSArray <NSString *>*)pageTitles;
@end

@interface YLBasePageViewController : WMPageController<YLBasePageControllerDataSource>
//标题样式 默认下划线样式
@property (nonatomic, assign) YLPageMenuStyle pageMenuStyle;
//标题高度默认
@property (nonatomic, assign) CGFloat pageViewMenuHeight;
//加载异常背景图
@property (nonatomic, strong) UIScrollView *blankScrollView;
@end

NS_ASSUME_NONNULL_END
