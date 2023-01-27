//
//  LRBaseNavigationController.m
//  LRKit
//
//  Created by lirui on 2022/1/7.
//

#import "LRBaseNavigationController.h"

@interface LRBaseNavigationController ()

@end

@implementation LRBaseNavigationController

#pragma mark - Public Methods

+ (instancetype)newWithRootViewController:(UIViewController *)rootViewController {
    return [[self alloc] initWithRootViewController:rootViewController];
}

- (void)removeViewController:(UIViewController *)needRemoveViewController {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers enumerateObjectsUsingBlock:^(id _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isEqual:needRemoveViewController]) {
            [viewControllers removeObject:viewController];
        }
    }];
    self.viewControllers = [viewControllers copy];
}

- (void)removeViewControllerOfClass:(Class)class {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers enumerateObjectsUsingBlock:^(id _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:class]) {
            [viewControllers removeObjectAtIndex:idx];
        }
    }];
    self.viewControllers = viewControllers;
}

- (void)removeViewControllerOfTheSameClass:(Class)aClass {
  NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
  viewControllers = (NSMutableArray *)[[viewControllers reverseObjectEnumerator] allObjects];
  
  __block NSUInteger numberOfTheClass = 0;
  [viewControllers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    UIViewController *viewController = [viewControllers objectAtIndex:idx];
    if ([viewController isKindOfClass:aClass]) {
      numberOfTheClass += 1;
      if (numberOfTheClass > 1) {
        [viewControllers removeObject:viewController];
      }
    }
  }];
  
  viewControllers = (NSMutableArray *)[[viewControllers reverseObjectEnumerator] allObjects];
  self.viewControllers = viewControllers;
}

- (UIViewController *)findViewControllerOfClass:(Class)aClass {
    UIViewController *viewController = nil;
    
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:aClass]) {
            viewController = vc;
            break;
        }
    }
    
    return viewController;
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - configure

- (void)configureView {
    [self configureDelegate];
    [self configureNavigationBar];
    [self configureNavigationBackItem];
}

- (void)configureDelegate {
    self.delegate = self;
}

- (void)configureNavigationBar {
    [[UINavigationBar appearance] setTranslucent:NO];
    self.navigationBar.tintColor = [UIColor darkTextColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName : [UIFont pingFangMedium:18.f], NSShadowAttributeName : [NSShadow new]};
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)configureNavigationBackItem {
    UIImage *backImage = [UIImage imageNamed:@"common_back_black"];
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.backIndicatorImage = backImage;
    navigationBar.backIndicatorTransitionMaskImage = backImage;
    
    UIBarButtonItem *backItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];
    UIOffset offset;
    offset.horizontal = - 500;
    [backItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Override Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = (self.viewControllers.count > 0);
    [super pushViewController:viewController animated:animated];
}

@end
