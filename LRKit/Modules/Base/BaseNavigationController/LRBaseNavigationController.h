//
//  LRBaseNavigationController.h
//  LRKit
//
//  Created by lirui on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+Utility.h"

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseNavigationController : UINavigationController <UINavigationControllerDelegate>

///创建新导航对象并设置根控制器
+ (instancetype)newWithRootViewController:(UIViewController *)rootViewController;

///移除导航控制器堆栈中的某个已经存在的ViewController
- (void)removeViewController:(UIViewController *)needRemoveViewController;

///通过类来移除导航控制器堆栈中的某个已经存在的ViewController
- (void)removeViewControllerOfClass:(Class)class;

@end

NS_ASSUME_NONNULL_END
