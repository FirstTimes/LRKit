//
//  UIApplication+Utility.h
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Utility)

///打开设置界面
+ (void)openSetting;

///拨打电话
+ (void)openPhoneWithNumber:(NSString *)number;

///能否打开指定的系统界面
+ (BOOL)canOpenUrlString:(NSString *)urlString;

///打开指定的系统界面
+ (void)openUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
