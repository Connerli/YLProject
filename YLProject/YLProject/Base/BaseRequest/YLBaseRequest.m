//
//  YLBaseRequest.m
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "YLBaseRequest.h"
#import <AFNetworkReachabilityManager.h>
#import "YLNetworkConfig.h"

#define UnkownFormatData -1
//是否打印网络请求数据信息
#define ENABLE_LOG 0

@interface YLBaseRequest () <YTKRequestDelegate, YTKRequestAccessory>
@property (nonatomic, copy) RequestSuccessBlock successBlock;
@property (nonatomic, copy) RequestFailedBlock failBlock;
@end

@implementation YLBaseRequest

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _loadingString       = nil;
        _showLodingIndicator = NO;
        _appendRND           = NO;
        _everLoaded          = NO;
    }
    return self;
}

#pragma mark - Super

- (NSTimeInterval)requestTimeoutInterval
{
    return 8;
}
//默认post 请求
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)baseUrl
{
    return @"";
}

- (id)requestArgument
{
    return [self getAllParameters];
}

#pragma mark - Public

- (instancetype)initWithRequestDelegate:(id<BaseRequestDelegate>)requestDelegate {
    if (self = [self init]) {
        self.requestDelegate = requestDelegate;
    }
    return self;
}

- (void)startLoad {
    [self reset];
    [self showStartLoadingHubIfNeeded];
    
    self.delegate = self;
    [self addAccessory:self];
    [self start];
    
    [self loadStartedCallDelegate];
    
#ifdef ENABLE_LOG
    NSString *requestUrl = [YLNetworkConfig URLStringWithBaseUrl:self.baseUrl requestUrl:self.requestUrl parameters:[self getAllParameters]];
    NSLog(@"%@",requestUrl);
#endif
    
}

- (void)fillModelWithDictionary:(NSDictionary *)dataDictionary {
    
}

- (void)fillModelWithArray:(NSArray *)dataArray {
    
}

- (void)fillModelWithUnexpectedFormatData:(NSData *)data {
    
}

// MARK:Block模式开启请求
- (void)startWithSuccessBlock:(RequestSuccessBlock)successBlock failedBlock:(RequestFailedBlock)failedBlock
{
    [self startWithSuccessBlock:successBlock failedBlock:failedBlock showWaitHub:NO];
}

- (void)startWithSuccessBlock:(RequestSuccessBlock)successBlock failedBlock:(RequestFailedBlock)failedBlock showWaitHub:(BOOL)isShowWaitHub {
    self.showLodingIndicator = isShowWaitHub;
    self.successBlock = successBlock;
    self.failBlock = failedBlock;
    
    [self showStartLoadingHubIfNeeded];
    
    __weak typeof(self)weakSelf = self;
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf requestFinished:request];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf requestFailed:request];
    }];
}

- (void)loginOut {
    
}

- (void)showErrorAlertWhenCodeNotZero {
    if (!self.networkEntity) {
        return;
    }
    
    if (self.networkEntity.code.integerValue == 500) {
        return;
    }
    
    [YLProgressHUD showErrorWithStatus:self.networkEntity.msg];
}

#pragma mark - Private
- (void)reset {
    _networkEntity = nil;
    if (self.isExecuting) {
        
    }
}

- (NSMutableDictionary *)getAllParameters {
    NSMutableDictionary *allParam = [[YLNetworkConfig globalParameters] mutableCopy];
    [allParam addEntriesFromDictionary:[self requestParameters]];
    if (self.appendRND) {
        allParam[@"rnd"] = @(arc4random());
    }
    return allParam;
}

- (NSDictionary *)requestParameters {
    return nil;
}

- (void)loadStartedCallDelegate {
    if (self.requestDelegate && [self.requestDelegate respondsToSelector:@selector(requestDidStartLoad:)]) {
        [self.requestDelegate requestDidStartLoad:self];
    }
}

- (void)loadSuccessdCallDelegate {
    if (self.requestDelegate && [self.requestDelegate respondsToSelector:@selector(requestDidFinishLoad:)]) {
        [self.requestDelegate requestDidFinishLoad:self];
    }
}

- (void)loadFailedCallDelegateWithError:(NSError *)error {
    if (self.requestDelegate && [self.requestDelegate respondsToSelector:@selector(request:didFailLoadWithError:)]) {
        [self.requestDelegate request:self didFailLoadWithError:error];
    }
}

- (void)showStartLoadingHubIfNeeded {
    if (!self.showLodingIndicator) { return;}
    
    if (self.loadingString.length > 0) {
        [YLProgressHUD showWithStatus:self.loadingString];
    } else {
        [YLProgressHUD show];
    }
}

- (void)showErrorMessageWithMsg:(NSString *)errorMsg {
    if (!self.ignoreErrorMessage) {
        [YLProgressHUD showErrorWithStatus:errorMsg];
    }
}

- (BOOL)isNetWorkAvailable {
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    } else {
        return YES;
    }
}

- (void)emptyDataCallBack {
    if (self.showLodingIndicator) {
        [YLProgressHUD showFailWithStatus:@"系统繁忙\n请稍后重试~"];
    }
    NSError *error = [NSError errorWithDomain:@"www.EmptyContent.com" code:500 userInfo:nil];
    [self loadFailedCallDelegateWithError:error];
    self.failBlock ? self.failBlock(error,NO):nil;
    
#ifdef ENABLE_LOG
    NSLog(@"%@:请求成功,数据为空", [NSString stringWithFormat:@"%@%@",self.baseUrl, self.requestUrl]);
#endif
}

- (void)successUnexpectedFormatDataCallBack {
    if (self.showLodingIndicator) {
        [YLProgressHUD dismiss];
    }
    [self fillModelWithUnexpectedFormatData:self.responseData];
    [self loadSuccessdCallDelegate];
    self.successBlock ? self.successBlock(self.responseJSONObject, self.responseString,UnkownFormatData, nil):nil;
    
#ifdef ENABLE_LOG
    NSLog(@"%@\n%@", [NSString stringWithFormat:@"%@%@",self.baseUrl, self.requestUrl],self.responseJSONObject);
#endif
    
}

- (void)successNomalDataCallBackWithData:(id)data returnCode:(NSString *)returnCode returnDesc:(NSString *)returnDesc {
    // 代理回调
    if ([data isKindOfClass:[NSDictionary class]]) {
        [self fillModelWithDictionary:data];
    } else if ([data isKindOfClass:[NSArray class]]){
        [self fillModelWithArray:data];
    } else {
        [self fillModelWithUnexpectedFormatData:self.responseData];
    }
    [self loadSuccessdCallDelegate];
#ifdef ENABLE_LOG
    NSLog(@"%@\n%@", [NSString stringWithFormat:@"%@%@",self.baseUrl, self.requestUrl],self.responseJSONObject);
#endif
    // block 回调
    self.successBlock ? self.successBlock(self.responseJSONObject, self.responseString, returnCode.integerValue, returnDesc):nil;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    self.everLoaded = YES;
    if (self.refreshView) {
        dispatch_main_async_safe(^{
            [self.refreshView hidePlaceImageView];
            [self.refreshView endRefreshSuccess:YES];
        });
    }
    // 1.empty data
    if ([NSString isEmpty:request.responseString]) {
        [self emptyDataCallBack];
        return;
    }
    
    // 2.XML data
    if (self.responseSerializerType == YTKResponseSerializerTypeXMLParser) {
        [self successUnexpectedFormatDataCallBack];
        return;
    }
    
    // 3.默认最外层为字典
    NSDictionary *resultDictionary = request.responseJSONObject;
    if (!resultDictionary || ![resultDictionary isKindOfClass:[NSDictionary class]]) {
        [self successUnexpectedFormatDataCallBack];
        return;
    }
    
    // 4.基础信息获取
    self.networkEntity = [YLNetworkEntity yy_modelWithJSON:resultDictionary];
    id data = self.networkEntity.data;
    
    // 5.异常数据
    if (!self.networkEntity.code.length) {
        [self successUnexpectedFormatDataCallBack];
        return;
    }
    
    if (self.showLodingIndicator) {
        [YLProgressHUD dismiss];
    }
    
    // 6.500为后端定义出错的code
    if (self.networkEntity.code.integerValue == 500) {
        [self showErrorMessageWithMsg:self.networkEntity.msg];
    }
    
    // 7.token失效code
    if (self.networkEntity.code.integerValue == -100) {
        [self loginOut];
        [self showErrorMessageWithMsg:self.networkEntity.msg];
    }
    
    // 8.正常数据
    [self successNomalDataCallBackWithData:data returnCode:self.networkEntity.code returnDesc:self.networkEntity.msg];
}

- (void)requestFailed:(YTKBaseRequest *)request {
    BOOL isNetworkError = NO;
    if (request.error.code == NSURLErrorNotConnectedToInternet || ![self isNetWorkAvailable]) {
        [self showErrorMessageWithMsg:@"网络不给力"];
        isNetworkError = YES;
    } else {
        [self showErrorMessageWithMsg:@"系统繁忙\n请稍后重试~"];
    }
    
    if (self.refreshView) {
        dispatch_main_async_safe(^{
            [self.refreshView hidePlaceImageView];
            [self.refreshView endRefreshSuccess:NO];
            if (isNetworkError) {
                [self.refreshView showPlaceImageWithType:PlaceImageTypeNetworkLost];
            }
        });
    }
    
    [self loadFailedCallDelegateWithError:request.error];
    self.failBlock ? self.failBlock(request.error, isNetworkError):nil;
    
#ifdef ENABLE_LOG
    NSString *url = [NSString stringWithFormat:@"%@%@",self.baseUrl, self.requestUrl];
    NSLog(@"\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Server Unavailable nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
    NSLog(@"%@ %@", url, request.error);
#endif
}


#pragma mark - YTKRequestAccessory
- (void)requestWillStart:(id)request {
  
}

- (void)requestWillStop:(id)request {
    
}

- (void)requestDidStop:(id)request {
  
}

@end
