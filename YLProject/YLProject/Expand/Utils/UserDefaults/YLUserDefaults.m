//
//  LDUserDefaults.m
//  Liaodao
//
//  Created by Conner on 2018/5/10.
//

#import "YLUserDefaults.h"

@implementation YLUserDefaults
- (BOOL)synchronize {
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
