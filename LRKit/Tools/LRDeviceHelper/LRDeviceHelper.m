//
//  LRDeviceHelper.m
//  LRKit
//
//  Created by lirui on 2022/1/17.
//

#import "LRDeviceHelper.h"
#include <sys/sysctl.h>

static LRDeviceHelper *_deviceHelper = nil;

@interface LRDeviceHelper ()

@property (nonatomic, copy) NSString *systemName;
@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, strong) NSDictionary *deviceNames;

@end

@implementation LRDeviceHelper

#pragma mark - initialization

+ (instancetype)shareDeviceHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceHelper = [[super allocWithZone:NULL] init];
        [_deviceHelper initProperties];
    });
    return _deviceHelper;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [LRDeviceHelper shareDeviceHelper];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [LRDeviceHelper shareDeviceHelper];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [LRDeviceHelper shareDeviceHelper];
}

#pragma mark - Public Methods

+ (NSString *)systemName {
    return [LRDeviceHelper shareDeviceHelper].systemName;
}

+ (NSString *)systemVersion {
    return [LRDeviceHelper shareDeviceHelper].systemVersion;
}

+ (NSString *)systemVersionName {
    return [NSString stringWithFormat:@"%@%@", [LRDeviceHelper systemName], [LRDeviceHelper systemVersion]];
}

+ (NSString *)machineModel {
    return [[LRDeviceHelper shareDeviceHelper] machineModel];
}

+ (NSString *)machineModelName {
    NSString *machineModel = [[LRDeviceHelper shareDeviceHelper] machineModel];
    NSString *machineModelName = [[LRDeviceHelper shareDeviceHelper].deviceNames objectForKey:machineModel];
  
    return machineModelName.length > 0 ? machineModelName : [NSString stringWithFormat:@"未知型号:%@", machineModel];
}

#pragma mark - Private Methods

- (void)initProperties {
    self.systemName = [UIDevice currentDevice].systemName;
    self.systemVersion = [UIDevice currentDevice].systemVersion;
    
    //https://www.theiphonewiki.com/wiki/Models
    self.deviceNames = @{
        @"iPhone4,1" : @"iPhone 4S",
        @"iPhone4,2" : @"iPhone 4S",
        @"iPhone4,3" : @"iPhone 4S",
        @"iPhone5,1" : @"iPhone 5",
        @"iPhone5,2" : @"iPhone 5",
        @"iPhone5,3" : @"iPhone 5C",
        @"iPhone5,4" : @"iPhone 5C",
        @"iPhone6,1" : @"iPhone 5S",
        @"iPhone6,2" : @"iPhone 5S",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone8,1" : @"iPhone 6S",
        @"iPhone8,2" : @"iPhone 6S Plus",
        @"iPhone8,4" : @"iPhone SE",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone11,2" : @"iPhone XS",
        @"iPhone11,4" : @"iPhone XS Max",
        @"iPhone11,6" : @"iPhone XS Max",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        @"iPhone12,8" : @"iPhone SE 2",
        @"iPhone13,1" : @"iPhone 12 mini",
        @"iPhone13,2" : @"iPhone 12",
        @"iPhone13,3" : @"iPhone 12 Pro",
        @"iPhone13,4" : @"iPhone 12 Pro Max",
        
        // 模拟器
        @"i386"       : @"Simulator",
        @"x86_64"     : @"Simulator",
        
        //iPads
        @"iPad1,1" : @"iPad 1G",
        @"iPad2,1" : @"iPad 2G",
        @"iPad2,2" : @"iPad 2G",
        @"iPad2,3" : @"iPad 2G",
        @"iPad2,4" : @"iPad 2G",
        @"iPad2,5" : @"iPad Mini",
        @"iPad2,6" : @"iPad Mini",
        @"iPad2,7" : @"iPad Mini",
        @"iPad3,1" : @"iPad 3G",
        @"iPad3,2" : @"iPad 3G",
        @"iPad3,3" : @"iPad 3G",
        @"iPad3,4" : @"iPad 4G",
        @"iPad3,5" : @"iPad 4G",
        @"iPad3,6" : @"iPad 4G",
        @"iPad4,1" : @"iPad Air",
        @"iPad4,2" : @"iPad Air",
        @"iPad4,3" : @"iPad Air",
        @"iPad4,4" : @"iPad Mini 2G",
        @"iPad4,5" : @"iPad Mini 2G",
        @"iPad4,6" : @"iPad Mini 2G",
        @"iPad4,7" : @"iPad Mini 3G",
        @"iPad4,8" : @"iPad Mini 3G",
        @"iPad4,9" : @"iPad Mini 3G",
        @"iPad5,1" : @"iPad Mini 4G",
        @"iPad5,2" : @"iPad Mini 4G",
        @"iPad5,3" : @"iPad Air 2G",
        @"iPad5,4" : @"iPad Air 2G",
        @"iPad6,3" : @"iPad Pro (9.7-inch)",
        @"iPad6,4" : @"iPad Pro (9.7-inch)",
        @"iPad6,7" : @"iPad Pro (12.9-inch)",
        @"iPad6,8" : @"iPad Pro (12.9-inch)",
        @"iPad6,11" : @"iPad 5",
        @"iPad6,12" : @"iPad 5",
        @"iPad7,1" : @"iPad Pro (12.9-inch) 2G",
        @"iPad7,2" : @"iPad Pro (12.9-inch) 2G",
        @"iPad7,3" : @"iPad Pro (10.5-inch) Inch",
        @"iPad7,4" : @"iPad Pro (10.5-inch) Inch",
        @"iPad7,5" : @"iPad 6G",
        @"iPad7,6" : @"iPad 6G",
        @"iPad7,11" : @"iPad 7G",
        @"iPad7,12" : @"iPad 7G",
        @"iPad8,1" : @"iPad Pro (11-inch)",
        @"iPad8,2" : @"iPad Pro (11-inch)",
        @"iPad8,3" : @"iPad Pro (11-inch)",
        @"iPad8,4" : @"iPad Pro (11-inch)",
        @"iPad8,5" : @"iPad Pro (12.9-inch) 3G",
        @"iPad8,6" : @"iPad Pro (12.9-inch) 3G",
        @"iPad8,7" : @"iPad Pro (12.9-inch) 3G",
        @"iPad8,8" : @"iPad Pro (12.9-inch) 3G",
        @"iPad8,9" : @"iPad Pro (12.9-inch) 3G",
        @"iPad8,10" : @"iPad Pro (11-inch) 2G",
        @"iPad8,11" : @"iPad Pro (11-inch) 2G",
        @"iPad8,12" : @"iPad Pro (12.9-inch) 4G",
        @"iPad11,1" : @"iPad Mini 5G",
        @"iPad11,2" : @"iPad Mini 5G",
        @"iPad11,3" : @"iPad Air 3G",
        @"iPad11,4" : @"iPad Air 3G",
        @"iPad11,6" : @"iPad 8G",
        @"iPad11,7" : @"iPad 8G",
        @"iPad13,1" : @"iPad Air 4G",
        @"iPad13,2" : @"iPad Air 4G",
        
        //iPods
        @"iPod1,1" : @"iPod Touch",
        @"iPod2,1" : @"iPod Touch 2G",
        @"iPod3,1" : @"iPod Touch 3G",
        @"iPod4,1" : @"iPod Touch 4G",
        @"iPod5,1" : @"iPod Touch 5G",
        @"iPod7,1" : @"iPod Touch 6G",
        @"iPod9,1" : @"iPod Touch 7G",
    };
}

- (NSString *)machineModel {
    static dispatch_once_t onceToken;
    static NSString *model;
        dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
  return model;
}

@end
