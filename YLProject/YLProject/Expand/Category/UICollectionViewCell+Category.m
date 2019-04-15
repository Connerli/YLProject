//
//  UICollectionViewCell+Category.m
//  Doctor
//
//  Created by Conner on 2017/8/28.
//  Copyright © 2017年 YiGeMed. All rights reserved.
//

#import "UICollectionViewCell+Category.h"

@implementation UICollectionViewCell (YLAdditions)
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellWithNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
