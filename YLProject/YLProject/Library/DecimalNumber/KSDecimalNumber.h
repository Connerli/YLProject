//
//  KSDecimalNumber.h
//  KSDecimalNumber
//
//  Created by zh.wang on 16/6/27.
//  Copyright © 2016年 guoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDecimalNumber : NSObject

/**
 *  加法
 *
 *  @param one 需要运算的数
 *  @param two 需要运算的数
 *
 *  @return 运算结果
 */
+ (NSString *)additionWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two;

/**
 *  减法
 *
 *  @param one 需要运算的数
 *  @param two 需要运算的数
 *
 *  @return 运算结果
 */
+ (NSString *)subtractionWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two;

/**
 *  乘法
 *
 *  @param one 需要运算的数
 *  @param two 需要运算的数
 *
 *  @return 运算结果
 */
+ (NSString *)multiplicationWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two;

/**
 *  除法
 *
 *  @param one 需要运算的数
 *  @param two 需要运算的数
 *
 *  @return 运算结果
 */
+ (NSString *)divisionWithOneNumber:(NSString *)one twoNumberString:(NSString *)two;

+ (NSComparisonResult)compareWithOneNumber:(NSString *)one twoNumberString:(NSString *)two;

/**
 *  保留小数操作
 *
 *  @param numberString 需要进行保留的数
 *  @param position     保留小数的位数
 *  @param roudingMode  保留小数位数的方式
 *
 *  NSRoundPlain,   // 可能是取整
 *  NSRoundDown,    // 只舍不入
 *  NSRoundUp,      // 只入不舍
 *  NSRoundBankers  // 四舍五入
 */
+ (NSString *)keepDecimalPlace:(NSString *)numberString In:(int)position roundingMode:(NSRoundingMode)roudingMode;
/**
 *  保留小数操作
 *
 *  @param numberString 需要进行保留的数
 *  @param min          保留小数的最小位数
 *  @param max          保留小数的最大位数
 *  @param roudingMode  保留小数位数的方式
 *
 *  NSRoundPlain,   // 可能是取整
 *  NSRoundDown,    // 只舍不入
 *  NSRoundUp,      // 只入不舍
 *  NSRoundBankers  // 四舍五入
 */
+ (NSString *)keepDecimalPlace:(NSString *)numberString min:(int)min max:(int)max roundingMode:(NSRoundingMode)roudingMode;

/**
 *  显示财务数字（默认采用四舍五入方式保留两位小数）
 *
 *  @param numberString 需要显示的财务数字
 *
 *  @return 财务数字
 */
+ (NSString *)showFinancialFiguresWithNumberString:(NSString *)numberString;

@end
