//
//  LRConfig.m
//  LRKit
//
//  Created by lirui on 2022/3/10.
//

#import <Foundation/Foundation.h>
#import "LRConfig.h"

#pragma mark - BaseURL

NSString *const LRServerApiBaseURLOnline = @"http://blade-gateway.zhaojiafang.com";
NSString *const LRServerApiBaseURLBeta = @"https://blade-gateway.stage.zhaojiafang.com";
NSString *const LRServerApiBaseURLLocal = @"http://blade-gateway.local.zhaojiafang.com";
NSString *const LRServerApiBaseURLTest1 = @"http://blade-gateway.test1.zhaojiafang.com";
NSString *const LRServerApiBaseURLTest2 = @"http://blade-gateway.test2.zhaojiafang.com";
NSString *const LRServerApiBaseURLTest3 = @"http://blade-gateway.test3.zhaojiafang.com";

#pragma mark - 环境初始配置，在Debug模式下默认为Test1环境，在Release模式下默认为线上环境

#if DEBUG == 1
NSString *LRServerApiBaseURL = LRServerApiBaseURLTest1;
#else
NSString *LRServerApiBaseURL = LRServerApiBaseURLOnline;
#endif
