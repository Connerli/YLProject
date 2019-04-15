//
//  YLMainRootViewController.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLMainRootViewController.h"
#import "YLMainTabbarController.h"

@interface YLMainRootViewController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@property (nonatomic, strong) YLMainTabBarController *tabBarController;

@end

@implementation YLMainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNewTabBar];
}

- (void)createNewTabBar {
    YLMainTabBarController *tabBarController = [[YLMainTabBarController alloc] init];
    tabBarController.delegate = self;
    self.viewControllers = @[tabBarController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
