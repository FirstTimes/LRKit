//
//  UIApplication+Utility.m
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import "UIApplication+Utility.h"

@implementation UIApplication (Utility)

+ (void)openSetting {
    if ([self canOpenUrlString:UIApplicationOpenSettingsURLString]) {
        [self openUrlString:UIApplicationOpenSettingsURLString];
    }
}

+ (void)openPhoneWithNumber:(NSString *)number {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel:%@", number];
    if ([UIApplication canOpenUrlString:phoneNumber]) {
        [UIApplication openUrlString:phoneNumber];
    }
}

+ (BOOL)canOpenUrlString:(NSString *)urlString {
    NSURL *URL = [NSURL URLWithString:urlString];
    return [[UIApplication sharedApplication] canOpenURL:URL];
}

+ (void)openUrlString:(NSString *)urlString {
    NSURL *URL = [NSURL URLWithString:urlString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}

@end
