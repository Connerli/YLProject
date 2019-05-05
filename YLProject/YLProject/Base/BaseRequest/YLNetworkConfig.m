//
//  YLNetworkConfig.m
//  YLProject
//
//  Created by Conner on 2019/4/15.
//  Copyright © 2019年 Conner. All rights reserved.
//  网路配置

#import <YTKNetworkConfig.h>
#import <YTKNetworkAgent.h>
#import <AFHTTPSessionManager.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <sys/utsname.h>
#import <AFNetworkReachabilityManager.h>

#import "YLNetworkConfig.h"
#import "YLAPPInfoTool.h"

@implementation YLNetworkConfig

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)configNetwork {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.securityPolicy = [self customSecurityPolicy];
    // TODO:通过 keyPath 设置的值，需要注意三方库有么有改这个字段
    YTKNetworkAgent *networkAgent = [YTKNetworkAgent sharedAgent];
    [networkAgent setValue:config.securityPolicy forKeyPath:@"manager.securityPolicy"];
}

- (AFSecurityPolicy *)customSecurityPolicy {
    
    //证书路径  暂时项目没有做证书支持 地址为空
    NSString *cerPath = @"";
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //容错处理，如果本地证书不存在，则使用 AF 默认策略不验证证书
    if([NSString isEmpty:cerPath]){
        AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [security setValidatesDomainName:NO];
        security.allowInvalidCertificates = YES;
        return security;
    }
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    //目前没有验证证书操作
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithArray:@[certData]];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

+ (NSDictionary *)globalParameters {
    //手机型号和系统表示格式："iphonex,iosx.x"
    NSString* sysVersion = [[UIDevice currentDevice] systemVersion];
    NSString* mobileVersion = [self mobileModel];
    sysVersion = [NSString stringWithFormat:@"%@,%@", mobileVersion, sysVersion];
    NSDictionary *params = [@{
                              @"appVersion": [YLAPPInfoTool getAppVersion],
                              @"platform":@"iOS"
                              } mutableCopy];
    return params;
    
}

//手机型号
+ (NSString *)mobileModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    return platform;
}

- (void)startMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
    }];
    [manager startMonitoring];
}

+ (NSString *)URLStringWithBaseUrl:(NSString *)baseUrl requestUrl:(NSString *)requestUrl parameters:(NSDictionary *)parameters {
    NSMutableString *URLString;
    if ([baseUrl hasSuffix:@"/"]) {
        URLString = [NSMutableString stringWithFormat:@"%@%@",baseUrl,requestUrl];
    } else {
        URLString = [NSMutableString stringWithFormat:@"%@/%@",baseUrl,requestUrl];
    }
    //获取字典的所有keys
    NSArray * keys = [parameters allKeys];
    //拼接字符串
    for (int i = 0; i < keys.count; i++){
        NSString *string;
        if (i == 0){
            //拼接时加？
            string = [NSString stringWithFormat:@"?%@=%@", keys[i], parameters[keys[i]]];
            
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", keys[i], parameters[keys[i]]];
        }
        //拼接字符串
        [URLString appendString:string];
    }
    return URLString;
}
@end
