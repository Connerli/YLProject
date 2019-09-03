//
//  YLBaseTableViewController.m
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "YLBaseTableViewController.h"

@interface YLBaseTableViewController ()

@end

@implementation YLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.refreshView];
    if (self.isCustomLayout) {
        [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(self.insets);
        }];
    } else {
        [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.view);
        }];
    }

}

#pragma mark - LazyLoad
- (YLRefreshTableView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[YLRefreshTableView alloc] init];
        _refreshView.delegate = self;
    }
    return _refreshView;
}


@end
