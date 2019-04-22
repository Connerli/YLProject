//
//  CYBaseCell.h
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 HuaLing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CYBaseCellModel;
@interface CYBaseCell : UITableViewCell
//数据
@property (nonatomic, strong) CYBaseCellModel *model;
//坐标
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(CYBaseCellModel *)model;
@end

NS_ASSUME_NONNULL_END
