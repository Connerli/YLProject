//
//  UICollectionViewCell+Category.h
//  Doctor
//
//  Created by Conner on 2017/8/28.
//  Copyright © 2017年 YiGeMed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Category)
+ (NSString *)cellReuseIdentifier;

+ (UINib *)cellWithNib;

@end
