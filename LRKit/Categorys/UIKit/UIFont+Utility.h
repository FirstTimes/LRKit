//
//  UIFont+Utility.h
//  zjfSeller
//
//  Created by lirui on 2021/4/1.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Utility)

///一般用于文本
+ (instancetype)pingFangRegular:(CGFloat)size;
+ (instancetype)pingFangSemibold:(CGFloat)size;
+ (instancetype)pingFangMedium:(CGFloat)size;

///一般用于数字和符号
+ (instancetype)helvetica:(CGFloat)size;
+ (instancetype)helveticaBold:(CGFloat)size;
+ (instancetype)helveticaMedium:(CGFloat)size;
+ (instancetype)helveticaCondensedBold:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
