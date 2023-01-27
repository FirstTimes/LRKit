//
//  UINavigationController+Utility.h
//  LRKit
//
//  Created by lirui on 2022/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Utility)

///导航控制器中是否已经包含某个ViewController
- (BOOL)containsViewControllerOfClass:(Class)class;

@end

NS_ASSUME_NONNULL_END
