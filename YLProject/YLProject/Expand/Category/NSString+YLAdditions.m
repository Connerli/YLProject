//
//  NSString+YLAdditions.m
//  PersonalProject
//
//  Created by conner on 2019/1/29.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "NSString+YLAdditions.h"

@implementation NSString (YLAdditions)
+ (BOOL)isEmpty:(NSString *)string {
    if ((NSNull *)string == [NSNull null]) {
        return YES;
    }
    if (string == nil || [string length] == 0) {
        return YES;
    } else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end
