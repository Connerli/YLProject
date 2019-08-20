//
//  YLBasePageViewController.m
//  YLProject
//
//  Created by Conner on 2019/4/25.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLBasePageViewController.h"

@interface YLBasePageViewController ()
@property (nonatomic, assign) CGFloat itemContentMargin; //menuViewItem 左右间隙增加的宽度和 跟itemMargin 不同
@end

@implementation YLBasePageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setupMenuViewTypeDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.blankScrollView];
    [self.blankScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    if (@available(iOS 11.0, *)) {
        self.blankScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark - Init
- (void)setupMenuViewTypeDefault {
    self.titleColorNormal = [UIColor hexString:@"#2B2A29"];
    self.titleColorSelected =  [UIColor hexString:@"#F83146"];
    self.titleSizeNormal = 17;
    self.titleSizeSelected = 19;
    self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressViewBottomSpace = 0;
    self.progressColor =  self.titleColorSelected;
    self.progressHeight = 3;
    //    self.progressWidth = 16;
    self.progressViewCornerRadius = 0;
    self.automaticallyCalculatesItemWidths = YES;
    self.pageViewMenuHeight = 39;
    self.itemMargin = 20;
}

- (void)setupMenuViewTypeUnderline {
    
}

- (void)setupMenuViewTypeSegmented {
    
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self pageTitles].count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [[self pageTitles] safeObjectAtIndex:index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [self pageControllerWithIndex:index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    //这里宽度width 如果设置了自动计算 YES 则返回字符串宽度  NO 返回 itemsWidths || menuItemWidth
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + self.itemContentMargin;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    if ([self respondsToSelector:@selector(pageMenuViewFrame)]) {
        return [self pageMenuViewFrame];
    }
    if (self.showOnNavigationBar) {
        CGFloat width = 0;
        for (NSInteger i = 0; i < [self numbersOfChildControllersInPageController:pageController]; i++) {
            width += [self menuView:menuView widthForItemAtIndex:i];
        }
        return CGRectMake(0, 0, width, self.pageViewMenuHeight);
    } else {
        return CGRectMake(0, 0, self.view.frame.size.width, self.pageViewMenuHeight);
    }
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    if ([self respondsToSelector:@selector(pageContentViewFrame)]) {
        return [self pageContentViewFrame];
    }
    if (self.showOnNavigationBar) {
        return self.view.bounds;
    } else {
        CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
        return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
    }
}

#pragma mark - WMPageControllerDelegate
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info atIndex:(NSInteger)index {
    
}


#pragma mark - CYBasePageControllerDataSource
- (NSArray<NSString *> *)pageTitles {
    return @[];
}

- (UIViewController *)pageControllerWithIndex:(NSInteger)index {
    return [UIViewController new];
}

#pragma mark - LazyLoad
- (UIScrollView *)blankScrollView {
    if (!_blankScrollView) {
        _blankScrollView = [[UIScrollView alloc] init];
        _blankScrollView.hidden = YES;
    }
    return _blankScrollView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
