//
//  UIScrollView+YLBlankPage.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PlaceImageType) {
    PlaceImageTypeNone = 0,               // 无
    PlaceImageTypeNetworkLost = 1,        // 网络问题
    PlaceImageTypeServerError = 2,        // 服务器接口报错
};

///点击图片回调
typedef void(^PlaceImageBlock)(PlaceImageType type);
///点击了label 回调
typedef void(^PlaceLabelBlock)(NSInteger i, PlaceImageType type);

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YLBlankPage)
@property (nonatomic ,copy) PlaceImageBlock  placeImageClickBlock; // 击事件的回调
@property (nonatomic, copy) PlaceLabelBlock  placeLabelBlock;      // 点击文字的回调
@property (nonatomic ,assign) PlaceImageType  placeImageType;       // 类型

/**
 显示空白页图 默认位置为 移除头部高度居中显示
 */
- (void)showPlaceImageWithType:(PlaceImageType)type;

/**
 显示空白页
 @param type 类型
 @param offset 偏移中心距离
 */
- (void)showPlaceImageWithType:(PlaceImageType)type contentOffset:(CGPoint)offset;

/*
 *隐藏占位图
 */
- (void)hidePlaceImageView;
@end

NS_ASSUME_NONNULL_END
