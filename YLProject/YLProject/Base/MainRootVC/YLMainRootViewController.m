//
//  YLMainRootViewController.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLMainRootViewController.h"
#import "YLMainTabbarController.h"
#import "YLMainTabBarConfig.h"

@interface YLMainRootViewController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@property (nonatomic, strong) YLMainTabBarController *tabBarController;

@end

@implementation YLMainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.hidden = YES;
    [self createNewTabBar];
}

- (void)createNewTabBar {
    [UIApplication sharedApplication].keyWindow.rootViewController = self.tabBarController;
}

- (UITabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [YLMainTabBarConfig sharedInstance].tabBarController;
    }
    return _tabBarController;
}

@end
