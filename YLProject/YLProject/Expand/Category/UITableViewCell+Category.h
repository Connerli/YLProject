//
//  UITableViewCell+Category.h
//  Created by Conner on 17/3/22.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UITableViewCell (Category)

+ (NSString *)cellReuseIdentifier;

+ (UINib *)cellWithNib;

@end
