//
//  CAGradientLayer+Utility.h
//  zjfSeller
//
//  Created by lirui on 2021/4/1.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAGradientLayer (Utility)

/// 水平方向渐变
+ (CAGradientLayer *)gradientLayerHorizontalDirectionWithStartColorHex:(NSString *)startColorHex endColorHex:(NSString *)endColorHex;

/// 垂直方向渐变
+ (CAGradientLayer *)gradientLayerVerticalDirectionWithStartColorHex:(NSString *)startColorHex endColorHex:(NSString *)endColorHex;

@end

NS_ASSUME_NONNULL_END
