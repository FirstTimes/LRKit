//
//  LRDeviceHelper.h
//  LRKit
//
//  Created by lirui on 2022/1/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRDeviceHelper : NSObject

/// 单例初始化
+ (instancetype)shareDeviceHelper;

///系统名称
+ (NSString *)systemName;

///系统版本
+ (NSString *)systemVersion;

///系统版本名称
+ (NSString *)systemVersionName;

///机型
+ (NSString *)machineModel;

///机型名称
+ (NSString *)machineModelName;

@end

NS_ASSUME_NONNULL_END
