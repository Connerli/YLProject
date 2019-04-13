//
//  CALayer+Category.m
//  Doctor
//
//  Created by Conner on 2018/1/30.
//  Copyright © 2018年 YiGeMed. All rights reserved.
//  

#import "CALayer+Category.h"

@implementation CALayer (Category)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
