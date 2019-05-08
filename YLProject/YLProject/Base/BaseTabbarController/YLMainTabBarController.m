//
//  YLBaseTabbarController.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLMainTabBarController.h"
#import "YLBaseNavigationController.h"
#import "YLHomeViewController.h"
#import "YLMeViewController.h"
#import "YLDiscoverViewController.h"

@interface YLMainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YLMainTabBarController

#pragma mark - Lifecycle
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment context:nil];
    [self customizeTabBarAppearance:tabBarController];
    return (self = (YLMainTabBarController *)tabBarController);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)viewControllers {
    YLBaseNavigationController *homeNavigation = [[YLBaseNavigationController alloc] initWithRootViewController:[[YLHomeViewController alloc] init]];
    YLBaseNavigationController *discoverNavigation = [[YLBaseNavigationController alloc] initWithRootViewController:[[YLDiscoverViewController alloc] init]];
    YLBaseNavigationController *meNavigation = [[YLBaseNavigationController alloc] initWithRootViewController:[[YLMeViewController alloc] init]];
    NSArray *viewControllers = @[homeNavigation,discoverNavigation,meNavigation];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",
                                                 CYLTabBarItemSelectedImage : @"home_highlight",
                                                 };
    NSDictionary *secondTabbarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"发现",
                                                  CYLTabBarItemImage : @"discover_normal",
                                                  CYLTabBarItemSelectedImage : @"discover_highlight",
                                                  };
    
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage :@"me_normal",
                                                 CYLTabBarItemSelectedImage:@"me_highlight",
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabbarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //        tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    [tabBarController rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor hexString:@"#89CCD6"];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
}


@end
