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
    self.view.backgroundColor = [UIColor whiteColor];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
}

- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
