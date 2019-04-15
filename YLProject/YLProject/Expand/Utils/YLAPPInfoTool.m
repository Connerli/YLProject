//
//  YLAPPInfoTool.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLAPPInfoTool.h"

@implementation YLAPPInfoTool
+ (NSString *)getAppDisplayName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppBuildNumber {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)getIpaBuildTime
{
    NSString *buildDate = [NSString stringWithFormat:@"%s %s",__DATE__, __TIME__];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.dateFormat = @"MMM dd yyyy HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:buildDate];
    NSString *dateString = [YLTimeUtils timeStringWithDate:date format:Second_To_Date_Format_yyyy_MM_dd_HH_mm];
    return dateString;
}

@end
