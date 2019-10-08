//
//  YLBaseViewController.m
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "YLBaseViewController.h"

@interface YLBaseViewController ()

@end

@implementation YLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - YLNavigationControllerProtocol
- (void)navigationWillShowMeAndHideViewController:(UIViewController *)viewController {
    BOOL MeHide = [self shouldHideNavigationBar];
    BOOL oldHide = NO;
    
    if (viewController && [viewController respondsToSelector:@selector(shouldHideNavigationBar)]) {
        oldHide = [[viewController performSelector:@selector(shouldHideNavigationBar)] boolValue];
    }
    
    if (oldHide && !MeHide) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if(!oldHide && MeHide){
        if (viewController) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        } else {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }
    }
}

- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
