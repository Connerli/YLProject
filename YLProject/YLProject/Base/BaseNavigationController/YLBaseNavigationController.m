//
//  YLBaseNavigationController.m
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "YLBaseNavigationController.h"
#import "YLNavigationControllerProtocol.h"

@interface YLBaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, weak) UIViewController *lastTopViewController;
@end

@implementation YLBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.navigationBar.translucent = NO;
    [self.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
}

#pragma mark - Super Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /* 原controller将消失回调 (self.lastViewController == viewController:tabbar切换index)*/
    if (self.lastTopViewController && self.lastTopViewController != viewController && [self.lastTopViewController respondsToSelector:@selector(navigationWillHideMeAndShowViewController:)]) {
        [self.lastTopViewController performSelector:@selector(navigationWillHideMeAndShowViewController:) withObject:viewController];
    }
    
    /** 新controller 将出现回调 */
    if ([viewController respondsToSelector:@selector(navigationWillShowMeAndHideViewController:)]) {
        [viewController performSelector:@selector(navigationWillShowMeAndHideViewController:) withObject:self.lastTopViewController];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /** 原controller 消失回调 */
    if (self.lastTopViewController && self.lastTopViewController != viewController && [self.lastTopViewController respondsToSelector:@selector(navigationDidHideMeAndShowViewController:)]) {
        [self.lastTopViewController performSelector:@selector(navigationDidHideMeAndShowViewController:) withObject:viewController];
    }
    
    /** 新controller 出现回调 */
    if ([viewController respondsToSelector:@selector(navigationDidShowMeAndHideViewController:)]) {
        [viewController performSelector:@selector(navigationDidShowMeAndHideViewController:) withObject:self.lastTopViewController];
    }
    
    self.lastTopViewController = viewController;
}

@end
