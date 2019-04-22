//
//  YLBaseCellModel.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBaseCellModel : NSObject

@property (nonatomic, strong) NSIndexPath *indexPath;
/** cell 点击事件的代理 */
@property (nonatomic, weak) id delegate;
/** cell的Identifier; */
@property (nonatomic, copy) NSString *cellIdentifier;

/** item对应的cell类 */
- (Class)cellClass;

@end

NS_ASSUME_NONNULL_END
