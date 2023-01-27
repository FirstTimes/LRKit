//
//  LRSuspensionWindow.h
//  zjfSeller
//
//  Created by lirui on 2021/4/12.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LRSuspensionWindowLeanType) {
    // 只吸附在左右两边
    LRSuspensionViewLeanTypeHorizontal,
    // 吸附在四边
    LRSuspensionViewLeanTypeEachSide
};

@interface LRSuspensionWindow : UIWindow

@property (nonatomic, assign) LRSuspensionWindowLeanType leanType;

+ (instancetype)shareInstance;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
