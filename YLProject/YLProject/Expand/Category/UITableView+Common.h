//
//  UITableView+Common.h
//
//
//  Created by Conner on 17/3/22.
//
//  添加分割线

#import <UIKit/UIKit.h>

@interface UITableView (Common)
/**
 *  为UITableViewCell添加分割线（默认是添加分区线为添加长线）
 *
 *  @param cell           cell
 *  @param indexPath      indexPath
 *  @param leftSpace      分割线左边离cell距离
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;

/**
 *  为UITableViewCell添加分割线（可选择是否添加分区线）
 *
 *  @param cell           cell
 *  @param indexPath      indexPath
 *  @param leftSpace      分割线左边离cell距离
 *  @param hasSectionLine section上面和下面是否有分割线
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;
/**
 *  为UITableViewCell添加分割线 （不考虑分区情况，直接添加短线）
 *
 *  @param cell           cell
 *  @param indexPath      indexPath
 *  @param leftSpace      分割线左边离cell距离
 */
- (void)addShortLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
@end
