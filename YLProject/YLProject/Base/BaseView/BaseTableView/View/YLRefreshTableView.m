//
//  YLRefreshTableView.m
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLRefreshTableView.h"
#import "YLBaseTableView.h"
#import "YLBaseCellModel.h"
#import "YLBaseCell.h"

@interface CYRefreshDelegateForward : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<YLTableViewDelegate, UITableViewDataSource> outSideDelegate;
@property (nonatomic, weak) YLRefreshTableView *tableView;
@end

@interface YLRefreshTableView ()
@property (nonatomic, strong) CYRefreshDelegateForward *forwarder;
@end

@implementation YLRefreshTableView

#pragma mark - Init
- (instancetype)init {
    return [self initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return ([self initWithFrame:frame style:UITableViewStylePlain]);
}

#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        _items = [[NSMutableArray alloc] init];
        _forwarder = [[CYRefreshDelegateForward alloc] init];
        _forwarder.tableView = self;
        
        _tableView = [[YLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:style];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}

- (__kindof YLBaseCellModel*)objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    if ([self itemsDoubleDimensionalArray]) {
        return [[_items safeObjectAtIndex:indexPath.section] safeObjectAtIndex:indexPath.row];
    } else {
        return [_items safeObjectAtIndex:indexPath.row];
    }
}

- (void)autoLoadingWithAnimation {
    [self.tableView autoLoadingWithAnimation];
}

- (void)endRefreshSuccess:(BOOL)success {
    
    [self.tableView endRefreshSuccess:success];
}

- (void)endLoadMoreSuccess:(BOOL)success {
    [self.tableView endLoadMoreSuccess:success];
}

- (void)endLoadMoreNoMoreData {
    [self.tableView endLoadMoreNoMoreData];
}

- (void)hidePlaceImageView {
    [self.tableView hidePlaceImageView];
}

- (void)showPlaceImageWithType:(PlaceImageType)type {
    if (![self.tableView isHaveData]) {
        [self.tableView showPlaceImageWithType:type];
    }
}

- (void)showPlaceImageWithType:(PlaceImageType)type contentOffset:(CGPoint)offset {
    if (![self.tableView isHaveData]) {
        [self.tableView showPlaceImageWithType:type contentOffset:offset];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Private
/// 一维数组还是二维数组
- (BOOL)itemsDoubleDimensionalArray {
    if ([_items.firstObject isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

/// tableView 分组数量
- (NSInteger)sectionCount {
    if (_items.count > 0) {
        // 二维数组返回二维数组个数
        if ([self itemsDoubleDimensionalArray]) {
            return _items.count?:1;
            // 一维数组返回
        } else {
            return 1;
        }
    } else {
        return 0;
    }
}

/// tableView 每组的row数量
- (NSInteger)rowCountWithSection:(NSInteger)section {
    if (_items.count > 0) {
        // 二维数组返回二维数组对应section row个数 一维数组返回 分区个数为一
        if ([self itemsDoubleDimensionalArray]) {
            NSArray *tempArray = [_items safeObjectAtIndex:section];
            return tempArray.count;
        } else {
            return _items.count;
        }
    } else {
        return 0;
    }
}

- (NSArray *)splitArrayWith:(NSArray *)array membersCount:(NSInteger )count {
    if (!array.count || count <= 0) { return [NSArray array];}
    if (count > array.count) { return [NSArray arrayWithObject:array];}
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i = 1; i <= (NSInteger)ceil(array.count/(count * 1.0) ); i++) {
        NSInteger loc = (i - 1) * count;
        NSInteger len = MIN(count, array.count - loc);
        NSRange r = NSMakeRange(loc, len);
        [arrM addObject:[array subarrayWithRange:r]];
    }
    return arrM;
}

#pragma mark - Setter & Getter

- (void)setDelegate:(id<YLTableViewDelegate>)delegate {
    _delegate = delegate;
    _forwarder.outSideDelegate = (id<YLTableViewDelegate,UITableViewDelegate,UITableViewDataSource>)delegate;
    
    _tableView.delegate = _forwarder;
    _tableView.dataSource = _forwarder;
}

- (void)setItems:(NSMutableArray *)items {
    _items = items;
    if (![self itemsDoubleDimensionalArray] && self.sectionMembersCount > 0) {
        _items = [self splitArrayWith:items membersCount:self.sectionMembersCount];
    }
    [self.tableView reloadData];
}

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    self.tableView.separatorStyle = separatorStyle;
}

- (void)setStartRefreshBlock:(TableViewStartRefreshBlock)startRefreshBlock {
    self.tableView.startRefreshBlock = startRefreshBlock;
}

- (void)setStartLoadMoreBlock:(TableViewStartLoadMoreBlock)startLoadMoreBlock {
    self.tableView.startLoadMoreBlock = startLoadMoreBlock;
}

- (void)setIsAdjustContentInset:(BOOL)isAdjustContentInset {
    _isAdjustContentInset = isAdjustContentInset;
    [self.tableView setIsAdjustContentInset:isAdjustContentInset];
}

- (UIView *)tableHeaderView {
    return self.tableView.tableHeaderView;
}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    self.tableView.tableHeaderView = tableHeaderView;
}

- (UIView *)tableFooterView {
    return self.tableView.tableFooterView;
}

- (void)setTableFooterView:(UIView *)tableFooterView {
    self.tableView.tableFooterView = tableFooterView;
}

@end

@implementation CYRefreshDelegateForward

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate numberOfSectionsInTableView:tableView];
    }
    return [self.tableView sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate tableView:tableView numberOfRowsInSection:section];
    }
    return [self.tableView rowCountWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    YLBaseCellModel *object = [self.tableView objectForRowAtIndexPath:indexPath];
    if (!object ||![object isKindOfClass:[YLBaseCellModel class]]){
        return nil;
    }
    object.indexPath = indexPath;
    
    UITableViewCell *cell = nil;
    Class cellClass = [object cellClass];
    NSString *identifier = NSStringFromClass(cellClass);
    if (object.cellIdentifier) {
        cell = [tableView dequeueReusableCellWithIdentifier:object.cellIdentifier];
        if (cell == nil) {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:object.cellIdentifier];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifier];
        }
    }
    
    if ([cell isKindOfClass:[YLBaseCell class]]) {
        YLBaseCell *tempCell = (YLBaseCell *)cell;
        [tempCell setModel:object];
        tempCell.indexPath = indexPath;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    YLBaseCellModel *object = [self.tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [object cellClass];
    return [cellClass tableView:tableView rowHeightForItem:object];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        [_outSideDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLBaseCellModel *object = (YLBaseCellModel *)[self.tableView objectForRowAtIndexPath:indexPath];
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:@selector(tableView:didSelectObject:atIndexPath:)]) {
        [_outSideDelegate tableView:(YLBaseTableView *)tableView didSelectObject:object atIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate tableView:tableView heightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_outSideDelegate && [_outSideDelegate respondsToSelector:_cmd]) {
        return [_outSideDelegate tableView:tableView heightForFooterInSection:section];
    }
    
    if (self.tableView.tableView.style == UITableViewStyleGrouped && section < self.tableView.items.count - 1) {
        return 10;
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark - 消息分发

- (BOOL)respondsToSelector:(SEL)selector {
    return [self.outSideDelegate respondsToSelector:selector] || [super respondsToSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _outSideDelegate;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}


@end
