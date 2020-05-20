//
//  FTMobileAgent.h
//  FTMobileAgent
//
//  Created by 胡蕾蕾 on 2019/11/28.
//  Copyright © 2019 hll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTMobileConfig.h"
#import "FTTrackBean.h"

NS_ASSUME_NONNULL_BEGIN
@class CBUUID;
@interface UIView (FTMobileSdk)
/**
 * 设置自定义的视图树描述
 */
@property (nonatomic, copy) NSString *viewVtpDescID;
/**
 * 适用于 TableView CollectionView
 * 是否在视图树中拼接 点击的 NSIndexPath
*/
@property (nonatomic, assign) BOOL vtpAddIndexPath;

@end

@interface FTMobileAgent : NSObject
#pragma mark ========== init instance ==========
/**
 * 仅用于启动位置信息状态获取
*/
+ (void)startLocation:(nullable void (^)(NSInteger errorCode, NSString * _Nullable errorMessage))callBack;
/**
 * @abstract
 * 返回之前所初始化好的单例
 *
 * @discussion
 * 调用这个方法之前，必须先调用 startWithConfigOptions 这个方法
 *
 * @return 返回的单例
*/
+ (instancetype)sharedInstance;
/**
 * SDK 初始化方法
 * @param configOptions     配置参数
*/
+ (void)startWithConfigOptions:(FTMobileConfig *)configOptions;
/**
 * 主动埋点，追踪自定义事件。 存储数据库，等待上传
 * @param measurement      当前数据点所属的指标集
 * @param field     自定义指标
*/
- (void)trackBackground:(NSString *)measurement  field:(NSDictionary *)field;
/**
 * 主动埋点，追踪自定义事件。有tags  存储数据库，等待上传
 * @param measurement      当前数据点所属的指标集
 * @param tags       自定义标签
 * @param field     自定义指标
 */
- (void)trackBackground:(NSString *)measurement tags:(nullable NSDictionary*)tags field:(NSDictionary *)field;
/**
 * 主动埋点，追踪自定义事件。有tags  立即上传 回调上传结果
 * @param measurement     当前数据点所属的指标集
 * @param field           自定义指标
*/
- (void)trackImmediate:(NSString *)measurement  field:(nullable NSDictionary *)field callBack:(nullable void (^)(NSInteger statusCode,_Nullable id responseObject))callBackStatus;
/**
 * 主动埋点，追踪自定义事件。   立即上传 回调上传结果
 * @param measurement      当前数据点所属的指标集
 * @param tags             自定义标签
 * @param field            自定义指标
*/
- (void)trackImmediate:(NSString *)measurement tags:(nullable NSDictionary *)tags field:(NSDictionary *)field callBack:(nullable void (^)(NSInteger statusCode,_Nullable id responseObject))callBackStatus;
/**
 * 主动埋点，可多条上传。   立即上传 回调上传结果
 * @param trackList     主动埋点数据数组   如果FTTrackBean 中timeMillis 传入格式错误，会自动赋值当前时间
*/
- (void)trackImmediateList:(NSArray <FTTrackBean *>*)trackList callBack:(nullable void (^)(NSInteger statusCode, _Nullable id responseObject))callBackStatus;
/**
 * 上报流程图 有tags
 * @param product   指标集 命名只能包含英文字母、数字、中划线和下划线，最长 40 个字符，区分大小写
 * @param traceId   标示一个流程单的唯一 ID
 * @param name      流程节点名称
 * @param parent    当前流程节点的上一个流程节点的名称，如果是流程的第一个节点，可不上报
 * @param tags      自定义标签
 * @param duration  流程单在当前流程节点滞留时间或持续时间，毫秒为单位
 * @param field     自定义指标
*/
- (void)flowTrack:(NSString *)product traceId:(NSString *)traceId name:(NSString *)name parent:(nullable NSString *)parent tags:(nullable NSDictionary *)tags duration:(long)duration field:(nullable NSDictionary *)field;
/**
 * 上报流程图 无tags
 * @param product   指标集 命名只能包含英文字母、数字、中划线和下划线，最长 40 个字符，区分大小写
 * @param traceId   标示一个流程单的唯一 ID
 * @param name      流程节点名称
 * @param parent    当前流程节点的上一个流程节点的名称，如果是流程的第一个节点，可不上报
 * @param duration  流程单在当前流程节点滞留时间或持续时间，毫秒为单位
*/
- (void)flowTrack:(NSString *)product traceId:(NSString *)traceId name:(NSString *)name parent:(nullable NSString *)parent duration:(long)duration;
/**
 * 绑定用户信息
 * @param name      用户名
 * @param Id        用户Id
 * @param exts      用户其他信息
*/
- (void)bindUserWithName:(NSString *)name Id:(NSString *)Id exts:(nullable NSDictionary *)exts;
/**
 * 设置 监控上传周期
*/
-(void)setMonitorFlushInterval:(NSInteger)interval;
/**
 * 开启监控同步
*/
-(void)startMonitorFlush;
/**
 * 开启监控同步，并设置上传时间间隔，监控类型
 * @param interval    上传周期
 * @param type        监控类型 设置后会更改config中 monitorType的设置
*/
-(void)startMonitorFlushWithInterval:(NSInteger)interval monitorType:(FTMonitorInfoType)type;
/**
 * 关闭监控同步
*/
-(void)stopMonitorFlush;
/**
 * 在监控项设置抓取蓝牙后使用
 * 设置设备连接过的蓝牙外设 CBUUID 数组，建议用户将已连接过的设备使用NSUserDefault保存起来
 * 用于采集已连接设备相关信息
*/
-(void)setConnectBluetoothCBUUID:(nullable NSArray<CBUUID *> *)serviceUUIDs;
/**
 * 设置视图描述字典 key:视图ClassName  value:视图描述
 * 替换 流程图的 name parent
 * 增加 field:page_desc 描述 autoTrack 中的 current_page_name
*/
-(void)addPageDescDict:(NSDictionary <NSString*,id>*)dict;
/**
 * 设置视图树描述字典 key:视图树string  value:视图树描述
 * 增加 field:vtp_desc 描述 autoTrack 中的 vtp
*/
-(void)addVtpDescDict:(NSDictionary <NSString*,id>*)dict;
/**
 * 是否开启页面、视图树 描述
 */
-(void)isPageVtpDescEnabled:(BOOL)enable;
/**
 * 是否开启流程图中页面 描述
*/
-(void)isFlowChartDescEnabled:(BOOL)enable;
/**
 * 注销当前用户
*/
- (void)logout;
/**
 * 清空SDK
 */
- (void)resetInstance;

@end

NS_ASSUME_NONNULL_END
