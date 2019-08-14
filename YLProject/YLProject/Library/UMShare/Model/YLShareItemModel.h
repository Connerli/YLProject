//
//  YLShareItemModel.h
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLShareType) {
    YLShareTypeQQ,               // QQ好友
    YLShareTypeWechat,           // 微信好友
    YLShareTypeWechatSession,    // 微信朋友圈
    YLShareTypeQzone,            // QQ空间
    YLShareTypeSina,             // 新浪微博
    YLShareTypeCopy,             // 复制链接
    YLShareTypeSystemShare,      // 调用系统分享
};

@interface YLShareItemModel : NSObject
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) YLShareType type;

@end

NS_ASSUME_NONNULL_END
