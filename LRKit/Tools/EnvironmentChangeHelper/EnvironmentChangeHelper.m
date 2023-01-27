//
//  EnvironmentChangeHelper.m
//  zjfSeller
//
//  Created by lirui on 2021/4/12.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import "EnvironmentChangeHelper.h"
#import "LRConfig.h"

static NSString *const CurrentEnvironmentTypeSavedKey = @"CurrentEnvironmentType";

@implementation EnvironmentChangeHelper

+ (NSArray *)allEnvironmentNames {
    return @[@"Online", @"Beta", @"Test1", @"Test2", @"Test3"];
}

+ (NSArray *)allEnvironmentTypes {
    return @[@(EnvironmentTypeOnline), @(EnvironmentTypeBeta), @(EnvironmentTypeTest1), @(EnvironmentTypeTest2), @(EnvironmentTypeTest3)];
}

+ (void)saveSelectedEnvironmentType:(EnvironmentType)environmentType {
    [[NSUserDefaults standardUserDefaults] setObject:@(environmentType) forKey:CurrentEnvironmentTypeSavedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (EnvironmentType)currentEnvironmentType {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *savedEnvironmentType = [userDefaults objectForKey:CurrentEnvironmentTypeSavedKey] ?: @(EnvironmentTypeTest1);
        
    EnvironmentType currentEnvironmentType = [savedEnvironmentType integerValue];
    return currentEnvironmentType;
}

+ (NSString *)currentEnvironmentTitle {
    NSString *title = @"";
    switch ([self currentEnvironmentType]) {
        case EnvironmentTypeOnline:
            title = @"线上";
            break;
            
        case EnvironmentTypeBeta:
            title = @"预发";
            break;
            
        case EnvironmentTypeTest1:
            title = @"Test1";
            break;
            
        case EnvironmentTypeTest2:
            title = @"Test2";
            break;
            
        case EnvironmentTypeTest3:
            title = @"Test3";
            break;
    }
    
    return title;
}

+ (void)configEnvironment {
    switch ([self currentEnvironmentType]) {
        case EnvironmentTypeOnline:
            LRServerApiBaseURL = LRServerApiBaseURLOnline;
            break;
            
        case EnvironmentTypeBeta:
            LRServerApiBaseURL = LRServerApiBaseURLBeta;
            break;
            
        case EnvironmentTypeTest1:
            LRServerApiBaseURL = LRServerApiBaseURLTest1;
            break;
            
        case EnvironmentTypeTest2:
            LRServerApiBaseURL = LRServerApiBaseURLTest2;
            break;
            
        case EnvironmentTypeTest3:
            LRServerApiBaseURL = LRServerApiBaseURLTest3;
            break;
    }
}

@end
