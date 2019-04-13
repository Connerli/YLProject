//
//  KSDecimalNumber.m
//  KSDecimalNumber
//
//  Created by zh.wang on 16/6/27.
//  Copyright © 2016年 guoding. All rights reserved.
//

#import "KSDecimalNumber.h"

/* --NSRoundingMode--
 NSRoundPlain,   // 可能是取整
 NSRoundDown,    // 只舍不入
 NSRoundUp,      // 只入不舍
 NSRoundBankers  // 四舍五入
 */

@implementation KSDecimalNumber

+ (NSString *)additionWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two {
    NSDecimalNumber *oneDecimal = [[NSDecimalNumber alloc] initWithString:one];
    NSDecimalNumber *twoDecimal = [[NSDecimalNumber alloc] initWithString:two];
    NSDecimalNumber *operatingResult = [oneDecimal decimalNumberByAdding:twoDecimal];
    return [NSString stringWithFormat:@"%@", operatingResult];
}

+ (NSString *)subtractionWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two {
    NSDecimalNumber *oneDecimal = [[NSDecimalNumber alloc] initWithString:one];
    NSDecimalNumber *twoDecimal = [[NSDecimalNumber alloc] initWithString:two];
    NSDecimalNumber *operatingResult = [oneDecimal decimalNumberBySubtracting:twoDecimal];
    return [NSString stringWithFormat:@"%@", operatingResult];
}

+ (NSString *)multiplicationWithOneNumberString:(NSString *)one twoNumberString:(NSString *)two {
    NSDecimalNumber *oneDecimal = [[NSDecimalNumber alloc] initWithString:one];
    NSDecimalNumber *twoDecimal = [[NSDecimalNumber alloc] initWithString:two];
    NSDecimalNumber *operatingResult = [oneDecimal decimalNumberByMultiplyingBy:twoDecimal];
    return [NSString stringWithFormat:@"%@", operatingResult];
}

+ (NSString *)divisionWithOneNumber:(NSString *)one twoNumberString:(NSString *)two {
    NSDecimalNumber *oneDecimal = [[NSDecimalNumber alloc] initWithString:one];
    NSDecimalNumber *twoDecimal = [[NSDecimalNumber alloc] initWithString:two];
    NSDecimalNumber *operatingResult = [oneDecimal decimalNumberByDividingBy:twoDecimal];
    return [NSString stringWithFormat:@"%@", operatingResult];
}

+ (NSComparisonResult)compareWithOneNumber:(NSString *)one twoNumberString:(NSString *)two {
    NSDecimalNumber *oneDecimal = [[NSDecimalNumber alloc] initWithString:one];
    NSDecimalNumber *twoDecimal = [[NSDecimalNumber alloc] initWithString:two];
    return [oneDecimal compare:twoDecimal];
}

+ (NSString *)keepDecimalPlace:(NSString *)numberString In:(int)position roundingMode:(NSRoundingMode)roudingMode {
    NSDecimalNumberHandler *roundingHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roudingMode
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                               raiseOnOverflow:NO
                                                                                            raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSDecimalNumber *number = [[NSDecimalNumber alloc] initWithString:numberString];
    NSDecimalNumber *roudingNumber = [number decimalNumberByRoundingAccordingToBehavior:roundingHandler];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    [numberFormatter setMinimumFractionDigits:position];
    [numberFormatter setMaximumFractionDigits:position];
    return [numberFormatter stringFromNumber:roudingNumber];
}

+ (NSString *)keepDecimalPlace:(NSString *)numberString min:(int)min max:(int)max roundingMode:(NSRoundingMode)roudingMode {
    NSDecimalNumberHandler *roundingHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roudingMode
                                                                                                     scale:2
                                                                                          raiseOnExactness:NO
                                                                                           raiseOnOverflow:NO
                                                                                          raiseOnUnderflow:NO
                                                                                       raiseOnDivideByZero:NO];
    NSDecimalNumber *number = [[NSDecimalNumber alloc] initWithString:numberString];
    NSDecimalNumber *roudingNumber = [number decimalNumberByRoundingAccordingToBehavior:roundingHandler];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    [numberFormatter setMinimumFractionDigits:min];
    [numberFormatter setMaximumFractionDigits:max];
    [numberFormatter setMinimumIntegerDigits:1];
    return [numberFormatter stringFromNumber:roudingNumber];
}

+ (NSString *)showFinancialFiguresWithNumberString:(NSString *)numberString {
    NSDecimalNumber *number = [[NSDecimalNumber alloc] initWithString:numberString];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.maximumFractionDigits = 2;
    return [numberFormatter stringFromNumber:number];
}

@end
