//
//  YLShareView.m
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLShareView.h"
#import "YLShareItemCell.h"
#import "YLShareItemModel.h"

@interface YLShareView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collcetionview;
@property (nonatomic, strong) NSArray *array;

@end

@implementation YLShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"分享到";
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor hexString:@"#999999"];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@16);
            make.centerX.equalTo(self);
        }];
        
        [self addSubview:self.collcetionview];
        [self.collcetionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(6);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self.mas_height).offset(-(110 + ALBottomSafeMargin));
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor hexString:@"#F7F8F9"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collcetionview.mas_bottom);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(@10);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonBeTouch) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor hexString:@"#333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.bottom.equalTo(@(-ALBottomSafeMargin));
        }];
        
        if (self.array.count <= 4) {
            self.height -= 95;
        }
    }
    return self;
}

#pragma mark - Public
- (void)showWithAnimation {
    
}

#pragma mark - Private
- (void)buttonBeTouch {
    self.cancelBlock ? self.cancelBlock() : nil;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/4, 80+12);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLShareItemCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[YLShareItemCell className] forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YLShareItemModel *model = self.array[indexPath.row];
    self.shareBlock ? self.shareBlock(model): nil;
}

#pragma mark - Getter


- (NSArray *)array
{
    if (_array == nil) {
        
        NSMutableArray *itemsM = [NSMutableArray array];
        // QQ
        YLShareItemModel *qq = [[YLShareItemModel alloc] init];
        qq.name = @"QQ";
        qq.iconName = @"share_qq";
        qq.type = YLShareTypeQQ;
        [itemsM addObject:qq];
        
        YLShareItemModel *Qzone = [[YLShareItemModel alloc] init];
        Qzone.name = @"QQ空间";
        Qzone.iconName = @"share_qqkj";
        Qzone.type = YLShareTypeQzone;
        [itemsM addObject:Qzone];
        
        // 微信
        YLShareItemModel *wx = [[YLShareItemModel alloc] init];
        wx.name = @"微信";
        wx.iconName = @"share_weichat";
        wx.type = YLShareTypeWechat;
        [itemsM addObject:wx];
        
        YLShareItemModel *wechatSession = [[YLShareItemModel alloc] init];
        wechatSession.name = @"朋友圈";
        wechatSession.iconName = @"share_pyq";
        wechatSession.type = YLShareTypeWechatSession;
        [itemsM addObject:wechatSession];
        
        // 微博
        YLShareItemModel *sina = [[YLShareItemModel alloc] init];
        sina.name = @"微博";
        sina.iconName = @"share_weibo";
        sina.type = YLShareTypeSina;
        [itemsM addObject:sina];
        
        // 复制链接
        YLShareItemModel *copy = [[YLShareItemModel alloc] init];
        copy.name = @"复制链接";
        copy.iconName = @"set_share_copy";
        copy.type = YLShareTypeCopy;
        [itemsM addObject:copy];
        
        
        // 系统分享
        YLShareItemModel *more = [[YLShareItemModel alloc] init];
        more.name = @"更多";
        more.iconName = @"share_more";
        more.type = YLShareTypeSystemShare;
        [itemsM addObject:more];
        _array = [NSArray arrayWithArray:itemsM];
        
    }
    return _array;
}

- (UICollectionView *)collcetionview
{
    if (_collcetionview == nil)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collcetionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 165) collectionViewLayout:flowLayout];
        _collcetionview.dataSource = self;
        _collcetionview.delegate = self;
        _collcetionview.backgroundColor = [UIColor whiteColor];
        _collcetionview.showsVerticalScrollIndicator = YES;
        [_collcetionview registerClass:[YLShareItemCell class] forCellWithReuseIdentifier:[YLShareItemCell className]];
    }
    return _collcetionview;
}

@end
