//
//  LRBaseViewController.m
//  LRKit
//
//  Created by lirui on 2021/7/22.
//

#import "LRBaseViewController.h"

@interface LRBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation LRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"🔥🔥🔥%@ Dealloc🔥🔥🔥", NSStringFromClass([self class]));
}

#pragma mark - PopGestureRecognizer

- (void)popGestureRecognizerEnable {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popGestureRecognizerDisable {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - NavigationController

- (void)backViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TabBarController 处理TabBar不遮挡界面

- (void)baseConfigureExtendedLayout {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 滚动视图偏移调整

- (void)baseConfigureScrollViewInsets {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
