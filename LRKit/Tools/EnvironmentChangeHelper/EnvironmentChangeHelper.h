//
//  EnvironmentChangeHelper.h
//  zjfSeller
//
//  Created by lirui on 2021/4/12.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EnvironmentType) {
    EnvironmentTypeOnline = 0,    // 线上环境 (Online)
    EnvironmentTypeBeta = 1,      // 预发环境(Beta)
    EnvironmentTypeTest1 = 2,     // test1环境 (Test1)
    EnvironmentTypeTest2 = 3,     // test2环境 (Test2)
    EnvironmentTypeTest3 = 4,     // test3环境 (Test3)
};

@interface EnvironmentChangeHelper : NSObject

+ (NSArray *)allEnvironmentNames;
+ (NSArray *)allEnvironmentTypes;

+ (void)saveSelectedEnvironmentType:(EnvironmentType)environmentType;
+ (EnvironmentType)currentEnvironmentType;
+ (NSString *)currentEnvironmentTitle;
+ (void)configEnvironment;

@end

NS_ASSUME_NONNULL_END
