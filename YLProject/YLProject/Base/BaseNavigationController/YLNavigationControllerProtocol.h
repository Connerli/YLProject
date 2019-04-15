//
//  YLNavigationControllerProtocol.h
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLNavigationControllerProtocol <NSObject>

@optional

// push me notice
- (void)navigationWillShowMeAndHideViewController:(UIViewController*)viewController;
- (void)navigationDidShowMeAndHideViewController:(UIViewController*)viewController;;

// push next controller or pop me notice
- (void)navigationWillHideMeAndShowViewController:(UIViewController*)viewController;
- (void)navigationDidHideMeAndShowViewController:(UIViewController*)viewController;

// return @YES to indicate that vc want to hide navigationbar
- (NSNumber *)shouldHideNavigationBar;
@end

NS_ASSUME_NONNULL_END
