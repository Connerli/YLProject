//
//  YLBaseAlertView.m
//  PersonalProjects
//
//  Created by Conner on 2018/6/25.
//  Copyright © 2018年 Conner. All rights reserved.
//

#import "YLBaseAlertView.h"
@interface YLBaseAlertView ()
//背景视图
@property (nonatomic, strong) UIView *maskView;
@end

@implementation YLBaseAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.maskView];
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

#pragma mark - Public Methods
- (void)showInKeyWindow {
    if (!self.isShow) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _show = YES;
    }
}

- (void)showInView:(UIView *)view {
    if (!self.isShow) {
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _show = YES;
    }
}

- (void)dismiss {
    [self hiddenFromSupperView];
}

#pragma mark - Private Methods
- (void)addTapGesInView:(UIView *)view {
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickMaskView)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
}

- (void)hiddenFromSupperView {
    _show = NO;
    [self removeFromSuperview];
    
}

- (void)didClickMaskView {
    [self dismiss];
}

#pragma mark - Lazy
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.6;
        [self addTapGesInView:_maskView];
    }
    return _maskView;
}

@end
