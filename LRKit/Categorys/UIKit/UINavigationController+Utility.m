//
//  UINavigationController+Utility.m
//  LRKit
//
//  Created by lirui on 2022/1/11.
//

#import "UINavigationController+Utility.h"

@implementation UINavigationController (Utility)

- (BOOL)containsViewControllerOfClass:(Class)class {
    __block BOOL isContains = NO;
    [self.viewControllers enumerateObjectsUsingBlock:^(id _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:class]) {
            isContains = YES;
            *stop = YES;
        }
    }];
    
    return isContains;
}

@end
