//
//  YLShareView.h
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YLShareItemModel;
@interface YLShareView : UIView
@property (nonatomic, copy) void (^shareBlock)(YLShareItemModel *model);
@property (nonatomic, copy) void (^cancelBlock)(void);

- (void)showWithAnimation;
@end

NS_ASSUME_NONNULL_END
