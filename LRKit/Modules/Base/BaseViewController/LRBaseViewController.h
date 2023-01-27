//
//  LRBaseViewController.h
//  LRKit
//
//  Created by lirui on 2021/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseViewController : UIViewController

- (void)popGestureRecognizerEnable;
- (void)popGestureRecognizerDisable;

- (void)backViewController;

@end

NS_ASSUME_NONNULL_END
