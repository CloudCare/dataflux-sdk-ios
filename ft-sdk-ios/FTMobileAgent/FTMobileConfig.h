//
//  ZYConfig.h
//  FTMobileAgent
//
//  Created by 胡蕾蕾 on 2019/12/6.
//  Copyright © 2019 hll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/* SDK版本 */
#define FT_SDK_VERSION @"1.0.0"

/* 默认应用版本 */
#define FT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
* @abstract
* AutoTrack 抓取信息
*
* @discussion
*   FTAutoTrackEventTypeAppStart       - 项目启动
*   FTAutoTrackEventTypeAppClick       - 点击事件
*   FTAutoTrackEventTypeAppViewScreen  - 页面的生命周期 open/close
*/
typedef NS_OPTIONS(NSInteger, FTAutoTrackEventType) {
    FTAutoTrackTypeNone          = 0,
    FTAutoTrackEventTypeAppStart      = 1 << 0,
    FTAutoTrackEventTypeAppClick      = 1 << 1,
    FTAutoTrackEventTypeAppViewScreen = 1 << 2,
};
/**
* @abstract
* TAG 中的设备信息
*
* @discussion
*   FTMonitorInfoTypeBattery  - 电池总量、使用量
*   FTMonitorInfoTypeMemory   - 内存总量、使用率
*   FTMonitorInfoTypeCpu      - CPU型号、占用率
*   FTMonitorInfoTypeCpu      - GPU型号、占用率
*   FTMonitorInfoTypeNetwork  - 网络的信号强度、网络速度、类型、代理
*   FTMonitorInfoTypeCamera   - 前置/后置 像素
*   FTMonitorInfoTypeLocation - 位置信息  eg:上海
*/
typedef NS_OPTIONS(NSInteger, FTMonitorInfoType) {
    FTMonitorInfoTypeAll          = 1 << 0,
    FTMonitorInfoTypeBattery      = 1 << 1,
    FTMonitorInfoTypeMemory       = 1 << 2,
    FTMonitorInfoTypeCpu          = 1 << 3,
    FTMonitorInfoTypeGpu          = 1 << 4,
    FTMonitorInfoTypeNetwork      = 1 << 5,
    FTMonitorInfoTypeCamera       = 1 << 6,
    FTMonitorInfoTypeLocation     = 1 << 7,
};
NS_ASSUME_NONNULL_BEGIN

@interface FTMobileConfig : NSObject
/**
指定初始化方法，设置 metricsUrl
@param metricsUrl FT-GateWay metrics 写入地址
@param akId       access key ID
@param akSecret   access key Secret
@param enableRequestSigning 配置是否需要进行请求签名 为YES 时akId与akSecret 不能为空
@return 配置对象
*/
- (instancetype)initWithMetricsUrl:(nonnull NSString *)metricsUrl akId:(nonnull NSString *)akId akSecret:(nonnull NSString *)akSecret enableRequestSigning:(BOOL)enableRequestSigning NS_DESIGNATED_INITIALIZER;
/// 禁用 init 初始化
- (instancetype)init NS_UNAVAILABLE;

/// 禁用 new 初始化
+ (instancetype)new NS_UNAVAILABLE;
#pragma mark - 基本设置
/* SDK版本 */
@property (nonatomic, copy) NSString *sdkVersion;

/* 应用版本(默认:info.plist中CFBundleShortVersionString对应的值)*/
@property (nonatomic, copy) NSString *appVersion;

/*应用名称（默认：info.plist中的CFBundleDisplayName）*/
@property (nonatomic ,copy) NSString *appName;

/*FT-GateWay metrics 写入地址*/
@property (nonatomic, copy) NSString *metricsUrl;

/*配置是否需要进行请求签名*/
@property (nonatomic, assign) BOOL enableRequestSigning;

/*access key ID*/
@property (nonatomic, copy) NSString *akId;

/*access key Secret*/
@property (nonatomic, copy) NSString *akSecret;

/*设置是否允许打印日志*/
@property (nonatomic, assign) BOOL enableLog;

/*TAG 中的设备信息*/
@property (nonatomic) FTMonitorInfoType monitorInfoType;

/*是否开启绑定用户数据*/
@property (nonatomic, assign) BOOL needBindUser;

#pragma mark ==========  FTAutoTrack 全埋点配置 ==========
/**
* 默认为NO   开启需要使用 FTAutoTrackSDK  总开关
*/
@property (nonatomic) BOOL enableAutoTrack;
/**
 * @property
 *
 * @abstract
 * 打开 SDK 设置追踪事件类型, 默认只追踪 App 启动 / 关闭、进入页面、元素点击
 *
 * @discussion
 * 该功能自动追踪 App 的一些行为，例如 SDK 初始化、App 启动 / 关闭、进入页面 等等，具体信息请参考文档:
 * 该功能默认关闭   开启需要使用 FTAutoTrackSDK 且 enableAutoTrack = YES
 */
@property (nonatomic) FTAutoTrackEventType autoTrackEventType;

/**
* @abstract
*  抓取某一类型的 View
*  与 黑名单  二选一使用  若都没有则为全抓取
*  eg: @[UITableView.class];
*/
@property (nonatomic,strong) NSArray<Class> *whiteViewClass;
/**
* @abstract
*  忽略某一类型的 View
*  与 白名单  二选一使用  若都没有则为全抓取
*/
@property (nonatomic,strong) NSArray<Class> *blackViewClass;

/**
*  抓取界面（实例对象数组）  白名单 与 黑名单 二选一使用  若都没有则为全抓取
* eg: @[@"HomeViewController"];  字符串类型
*/
@property (nonatomic,strong) NSArray *whiteVCList;
/**
*  抓取界面（实例对象数组）  黑名单 与白名单  二选一使用  若都没有则为全抓取
*/
@property (nonatomic,strong) NSArray *blackVCList;





@end

NS_ASSUME_NONNULL_END
