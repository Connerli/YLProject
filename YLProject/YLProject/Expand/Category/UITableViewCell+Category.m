//
//  UITableViewCell+Category.m
//  
//
//  Created by Conner on 17/3/22.
//

#import "UITableViewCell+Category.h"

@implementation UITableViewCell (Category)

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellWithNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
