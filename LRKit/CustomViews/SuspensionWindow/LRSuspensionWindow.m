//
//  LRSuspensionWindow.m
//  zjfSeller
//
//  Created by lirui on 2021/4/12.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import "LRSuspensionWindow.h"
#import "EnvironmentChangeHelper.h"
#import "LRConfig.h"
//#import "LoginHelper.h"

static LRSuspensionWindow *suspensionWindow = nil;
static const CGFloat WindowSide = 54.f;
static const CGFloat VerticalMargin = 15.f;
static const CGFloat LeanProportion = 8/55.0;

@interface LRSuspensionWindow ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation LRSuspensionWindow

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        suspensionWindow = [[LRSuspensionWindow alloc] init];
        [suspensionWindow configureViews];
    });
  
    return suspensionWindow;
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

#pragma mark - Private Methods

- (void)configureViews {
    [self configureWindow];
    [self configureTitleLabel];
    [self configureGestureRecognizer];
}

- (void)configureWindow {
    UIWindow *preKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    self.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - WindowSide, ([[UIScreen mainScreen] bounds].size.height - WindowSide) / 2, WindowSide, WindowSide);
    self.backgroundColor = [UIColor lightGrayColor];
    self.windowLevel = UIWindowLevelAlert;
    self.rootViewController = [UIViewController new];
    self.userInteractionEnabled = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = WindowSide / 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
    
    [self makeKeyAndVisible];
    
    if (preKeyWindow) {
        [preKeyWindow makeKeyAndVisible];
    }
    
    self.leanType = LRSuspensionViewLeanTypeHorizontal;
    
    CGFloat centerXSpace = (0.5 - LeanProportion) * WindowSide;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGPoint center = CGPointMake(screenWidth - centerXSpace, (screenHeight - WindowSide) / 2.0 - VerticalMargin);
    [UIView animateWithDuration:0.25 animations:^{
        self.center = center;
    }];
}

- (void)configureTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = [EnvironmentChangeHelper currentEnvironmentTitle];
    self.titleLabel.text = @"Test1";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)configureGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanLocationChanged:)];
    self.panGestureRecognizer.delaysTouchesBegan = NO;
    [self addGestureRecognizer:self.panGestureRecognizer];
  
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapClick:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)didPanLocationChanged:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [panGestureRecognizer locationInView:appWindow];
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded
             || panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        self.alpha = .7;
        
        CGFloat viewWidth = self.frame.size.width;
        CGFloat viewHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(panPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = 0;
        if (self.leanType == LRSuspensionViewLeanTypeHorizontal) {
            minSpace = MIN(left, right);
        }else{
            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        }
        CGPoint newCenter = CGPointZero;
        CGFloat targetY = 0;
        
        if (panPoint.y < VerticalMargin + viewHeight / 2.0) {
            targetY = VerticalMargin + viewHeight / 2.0;
        }else if (panPoint.y > (screenHeight - viewHeight / 2.0 - VerticalMargin)) {
            targetY = screenHeight - viewHeight / 2.0 - VerticalMargin;
        }else{
            targetY = panPoint.y;
        }
        
        CGFloat centerXSpace = (0.5 - LeanProportion) * viewWidth;
        CGFloat centerYSpace = (0.5 - LeanProportion) * viewHeight;

        if (minSpace == left) {
            newCenter = CGPointMake(centerXSpace, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(panPoint.x, centerYSpace);
        }else {
            newCenter = CGPointMake(panPoint.x, screenHeight - centerYSpace);
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.center = newCenter;
        }];
    }else{
        NSLog(@"panGestureRecognizer state : %zd", panGestureRecognizer.state);
    }
}

- (void)didTapClick:(nullable UITapGestureRecognizer *)tapGestureRecognizer {
    [self showActionSheetWithArray:[EnvironmentChangeHelper allEnvironmentTypes]];
}

- (void)showActionSheetWithArray:(NSArray *)environmentTypeArray {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"环境切换" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [environmentTypeArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull environmentType, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = @"";
        NSString *shortTitle = @"";
        switch ([environmentType integerValue]) {
            case EnvironmentTypeOnline:
                title = @"线上环境";
                shortTitle = @"线上";
                break;
                
            case EnvironmentTypeBeta:
                title = @"预发环境";
                shortTitle = @"预发";
                break;
                
            case EnvironmentTypeTest1:
                title = @"测试环境1";
                shortTitle = @"Test1";
                break;
                
            case EnvironmentTypeTest2:
                title = @"测试环境2";
                shortTitle = @"Test2";
                break;
                
            case EnvironmentTypeTest3:
                title = @"测试环境3";
                shortTitle = @"Test3";
                break;
        }
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [EnvironmentChangeHelper saveSelectedEnvironmentType:[environmentType integerValue]];
            [EnvironmentChangeHelper configEnvironment];
            self.titleLabel.text = shortTitle;
//            [LoginHelper logoutWithCompletion:^{
//                [LoginHelper showLoginViewController];
//            }];
            
            NSLog(@"BaseURL: %@", LRServerApiBaseURL);
        }];
        
        [actionSheet addAction:defaultAction];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"BaseURL: %@", LRServerApiBaseURL);
    }];
    [actionSheet addAction:cancelAction];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController  presentViewController:actionSheet animated:YES completion:nil];
}

@end
