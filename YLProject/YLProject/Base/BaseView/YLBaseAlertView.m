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

- (void)hiddenFromSupperView {
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
    _show = NO;
}

#pragma mark - Public Methods
- (void)showInKeyWindowWithAnimated:(BOOL)animated {
    if (!self.isShow) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.maskView];
        [keyWindow addSubview:self];
        if (_contentMode == AlertContentModeCenter) {
            self.centerX = keyWindow.centerX;
            self.centerY = keyWindow.centerY;
        } else if (_contentMode == AlertContentModeBottom) {
            self.centerY = keyWindow.centerY;
            self.bottom = keyWindow.bottom;
        }
        _show = YES;
    }
}

- (void)hiddenFromKeyWindowWithAnimated:(BOOL)animated {
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
    _show = NO;
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    if (!self.isShow) {
        [view addSubview:self.maskView];
        [view addSubview:self];
        self.centerX = view.centerX;
        self.centerY = view.centerY;
        _show = YES;
    }
}

- (void)hiddenFromView:(UIView *)view animated:(BOOL)animated {
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
    _show = NO;
}

//点击了背景图
- (void)didClickMaskView {
    [self hiddenFromSupperView];
}

#pragma mark - Lazy
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        [self addTapGesInView:_maskView];
    }
    return _maskView;
}

#pragma mark - Private Methods
- (void)addTapGesInView:(UIView *)view {
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickMaskView)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
}

@end
