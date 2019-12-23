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
#define ZY_SDK_VERSION @"1.0.0"

/* 默认应用版本 */
#define ZY_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/* 抓取事件 枚举 */
typedef NS_OPTIONS(NSInteger, FTAutoTrackEventType) {
    FTAutoTrackTypeNone          = 0,
    FTAutoTrackEventTypeAppStart      = 1 << 0,
    FTAutoTrackEventTypeAppEnd        = 1 << 1,
    FTAutoTrackEventTypeAppClick      = 1 << 2,
    FTAutoTrackEventTypeAppViewScreen = 1 << 3,
};
NS_ASSUME_NONNULL_BEGIN

@interface FTMobileConfig : NSObject
#pragma mark - 基本设置
// SDK版本
@property (nonatomic, copy) NSString *sdkVersion;

// 应用版本(默认:info.plist中CFBundleShortVersionString对应的值)
@property (nonatomic, copy) NSString *appVersion;
//应用名称（默认：info.plist中的CFBundleDisplayName）
@property (nonatomic ,copy) NSString *appName;
@property (nonatomic, copy) NSString *metricsUrl;

@property (nonatomic, assign) BOOL enableRequestSigning;

@property (nonatomic, copy) NSString *akId;

@property (nonatomic, copy) NSString *akSecret;

@property (nonatomic, assign) BOOL isDebug;


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


/// 是否自动收集 App Crash 日志，该功能默认是关闭的
//@property (nonatomic) BOOL enableTrackAppCrash;
@end

NS_ASSUME_NONNULL_END
