//
//  AppDelegate.m
//  LRKit
//
//  Created by lirui on 2021/7/22.
//

#import "AppDelegate.h"
#import "AppDelegate+Configure.h"
#import "LRBaseNavigationController.h"
#import "LRMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureEnvironmentSwitch];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LRBaseNavigationController *navigationController = [[LRBaseNavigationController alloc] initWithRootViewController:[LRMainViewController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
