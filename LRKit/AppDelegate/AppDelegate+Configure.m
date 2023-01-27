//
//  AppDelegate+Configure.m
//  LRKit
//
//  Created by lirui on 2022/3/10.
//

#import "AppDelegate+Configure.h"
#import "LRSuspensionWindow.h"
#import "EnvironmentChangeHelper.h"

@implementation AppDelegate (Configure)

//环境切换工具
- (void)configureEnvironmentSwitch {
#if DEBUG == 1
    [[LRSuspensionWindow shareInstance] show];
//    [EnvironmentChangeHelper configEnvironment];
#endif
}

@end
