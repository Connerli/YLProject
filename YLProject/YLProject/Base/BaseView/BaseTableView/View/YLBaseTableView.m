//
//  CYBaseTableView.m
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLBaseTableView.h"
#import "YLDIYRefreshHeader.h"
#import "YLDIYRefreshFooter.h"

@implementation YLBaseTableView

- (instancetype)init {
    return [self initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return ([self initWithFrame:frame style:UITableViewStylePlain]);
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(self) {
        self.isAdjustContentInset = NO;
        [self adaptive_iOS_11];
    }
    return (self);
}

#pragma mark - Super

- (void)reloadData {
    [super reloadData];
    
    if ([self visibleCells].count > 0) {
        self.mj_footer.hidden = NO;
    } else {
        self.mj_footer.hidden = YES;
    }
}

#pragma mark - Public

- (void)endRefreshSuccess:(BOOL)success {
    [self.mj_header endRefreshing];
    [self.mj_footer resetNoMoreData];
    [self.mj_footer endRefreshing];
}

- (void)endLoadMoreSuccess:(BOOL)success {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)endLoadMoreNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
    if ([self isHaveData]) {
        self.mj_footer.hidden = NO;
    } else {
        self.mj_footer.hidden = YES;
    }
}

- (BOOL)isHaveData {
    NSInteger numberOfSections = [self numberOfSections];
    BOOL havingData = NO;
    for (NSInteger i = 0; i < numberOfSections; i++) {
        if ([self numberOfRowsInSection:i] > 0) {
            havingData = YES;
            break;
        }
    }
    return havingData;
}

- (void)autoLoadingWithAnimation{
    [self.mj_header beginRefreshing];
    self.mj_footer.hidden = YES;
}

#pragma mark - Private

- (void)adaptive_iOS_11
{
#ifdef __IPHONE_11_0
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
#endif
}

#pragma mark - Setter

- (void)setIsAdjustContentInset:(BOOL)isAdjustContentInset{
    _isAdjustContentInset = isAdjustContentInset;
    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            if (isAdjustContentInset) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
}

- (void)setStartRefreshBlock:(TableViewStartRefreshBlock)startRefreshBlock {
    _startRefreshBlock = startRefreshBlock;
    @weakify(self);
    self.mj_header =  [YLDIYRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if(self.startRefreshBlock) {
            self.startRefreshBlock(self);
        }
    }];
}

- (void)setStartLoadMoreBlock:(TableViewStartLoadMoreBlock)startLoadMoreBlock {
    _startLoadMoreBlock = startLoadMoreBlock;
    @weakify(self);
    self.mj_footer =  [YLDIYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if(self.startLoadMoreBlock) {
            self.startLoadMoreBlock(self);
        }
    }];
}

@end
