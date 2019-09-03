//
//  YLMeViewController.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLMeViewController.h"


@interface YLMeViewController ()
@property (nonatomic, strong) NSArray *itemList;
@end

@implementation YLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}


- (NSArray *)itemList {
    if (!_itemList) {
        
    }
    return _itemList;
}

@end
