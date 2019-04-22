//
//  YLBaseCell.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YLBaseCellModel;
@interface YLBaseCell : UITableViewCell
//数据
@property (nonatomic, strong) YLBaseCellModel *model;
//坐标
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(YLBaseCellModel *)model;
@end

NS_ASSUME_NONNULL_END
