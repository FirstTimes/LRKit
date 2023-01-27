//
//  UIColor+Utility.h
//  LRKit
//
//  Created by lirui on 2021/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utility)

///随机颜色
+ (UIColor*)randomColor;
///通过16进制颜色色值来创建UIColor对象
+ (UIColor *)colorWithHexString:(NSString *)hexString;
///通过16进制颜色色值、透明度来创建UIColor对象
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
