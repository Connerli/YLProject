//
//  YLBaseRequest.h
//  PersonalProjects
//
//  Created by Conner on 2018/12/4.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "YTKBaseRequest.h"
#import "YLNetworkEntity.h"


#pragma mark - blcoks

/**
 请求成功后的回调
 
 @param resultDic    请求结果字典
 @param resultString 请求结果字符串
 @param code         状态码
 @param errorMsg     错误信息（code不为0时）
 */
typedef void(^RequestSuccessBlock)(id resultDic, id resultString, NSInteger code, NSString *errorMsg);

/**
 请求成功后的回调
 
 @param resultData    请求结果
 @param code         状态码
 @param errorMsg     错误信息（code不为0时）
 */
typedef void(^RequestXMLSuccessBlock)(id resultData, NSInteger code, NSString *errorMsg);

/**
 请求失败回调
 
 @param error 错误信息
 @param isNetworkError 是否网络不可用
 */
typedef void(^RequestFailedBlock)(NSError *error, BOOL isNetworkError);
#pragma mark -


@class YLBaseRequest;

@protocol BaseRequestDelegate <NSObject>
@optional
- (void)requestDidStartLoad:(YLBaseRequest *)request;
- (void)requestDidFinishLoad:(YLBaseRequest *)request;
- (void)request:(YLBaseRequest *)request didFailLoadWithError:(NSError*)error;
@end

@interface YLBaseRequest : YTKBaseRequest

/** 获取请求状态改变的代理,block回调无需设值 */
@property (nonatomic, weak) id <BaseRequestDelegate> requestDelegate;

/** 在请求中展示黑色加载菊花,请求失败的时候弹出失败原因,成功弹窗消失 */
@property (nonatomic, assign) BOOL showLodingIndicator;
/** 请求中黑色菊花上面的文字 */
@property (nonatomic, copy) NSString *loadingString;
/** 接口出错时忽略提示信息(example:后台接口) */
@property (nonatomic, assign) BOOL ignoreErrorMessage;

/** 在参数中拼接随机数 default:NO */
@property (nonatomic, assign) BOOL appendRND;

/** 基础数据模型 */
@property (nonatomic, strong) YLNetworkEntity *networkEntity;

/** 记录曾经加载成功过 */
@property (nonatomic, assign) BOOL everLoaded;

#pragma mark - Subclass Override

/** 子类重写参数字典 */
- (NSDictionary *)requestParameters;

/** 子类重写解析数据: 约定格式的数据 */
- (void)fillModelWithDictionary:(NSDictionary *)dataDictionary;

/** 子类重写解析数据: 约定格式的数据 */
- (void)fillModelWithArray:(NSArray *)dataArray;

/** 子类重写解析数据: 非约定格式的数据 */
- (void)fillModelWithUnexpectedFormatData:(NSData *)data;

/** 子类重写 处理登出事宜 */
- (void)loginOut;

#pragma mark -

/* 代理模式 初始化方法 */
- (instancetype)initWithRequestDelegate:(id<BaseRequestDelegate>)requestDelegate;

/** 代理模式 开启请求 */
- (void)startLoad;

/**
 block模式 发起网络请求(无加载动画)
 
 @param successBlock  成功回调
 @param failedBlock   失败回调
 */
- (void)startWithSuccessBlock:(RequestSuccessBlock)successBlock failedBlock:(RequestFailedBlock)failedBlock;

/**
 block模式 发起网络请求(可选加载动画)
 
 @param successBlock   成功回调
 @param failedBlock    失败回调
 @param isShowWaitHub  是否显示加载loading
 */
- (void)startWithSuccessBlock:(RequestSuccessBlock)successBlock failedBlock:(RequestFailedBlock)failedBlock showWaitHub:(BOOL)isShowWaitHub;
/**
 展示 code 非 0 提示
 */
- (void)showErrorAlertWhenCodeNotZero;

@end

