//
//  UIScreen+Utility.m
//  LRKit
//
//  Created by lirui on 2021/8/3.
//

#import "UIScreen+Utility.h"

@implementation UIScreen (Utility)

+ (CGSize)screenSize {
    return [self mainScreen].bounds.size;
}

+ (CGFloat)screenWidth {
    return [self mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [self mainScreen].bounds.size.height;
}

+ (CGFloat)screenScale {
    return [self mainScreen].scale;
}

//+ (CGFloat)topSafeAreaSpace {
//    if (@available(iOS 11.0, *)) {
//        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
//    } else {
//        return 0.f;
//    }
//}

+ (CGFloat)bottomSafeAreaSpace {
    return [self isNormalScreen] ? 0.f : 34.f;
}

+ (BOOL)isNormalScreen {
    if ([self is375_812Pt] || [self is414_896Pt] || [self is390_844Pt] || [self is428_926Pt]) {
        return NO;
    } else {
        return YES;
    }
}

+ (CGFloat)navigationBarHeight {
    return 44.f;
}

+ (CGFloat)statusAndNavigationBarHeight {
    return [self isNormalScreen] ? 64.f : 88.f;
}

+ (CGFloat)tabBarHeight {
    return [self bottomSafeAreaSpace] + 49.f;
}

+ (CGSize)sizeOf320_480Pt {
    return CGSizeMake(320.f, 480.f);
}

+ (CGSize)sizeOf320_568Pt {
    return CGSizeMake(320.f, 568.f);
}

+ (CGSize)sizeOf375_667Pt {
    return CGSizeMake(375.f, 667.f);
}

+ (CGSize)sizeOf375_812Pt {
    return CGSizeMake(375.f, 812.f);
}

+ (CGSize)sizeOf414_736Pt {
    return CGSizeMake(414.f, 736.f);
}

+ (CGSize)sizeOf414_896Pt {
    return CGSizeMake(414.f, 896.f);
}

+ (CGSize)sizeOf390_844Pt {
    return CGSizeMake(390.f, 844.f);
}

+ (CGSize)sizeOf428_926Pt {
    return CGSizeMake(428.f, 926.f);
}

#pragma mark - Private Methods

/// 判断屏幕尺寸为 320×480 pt 设备: iPhone4, iPhone4s
+ (BOOL)is320_480Pt {
  return [UIScreen screenWidth] == 320.f && [UIScreen screenHeight] == 480.f;
}

/// 判断屏幕尺寸为 320×568 pt 设备: iPhone5, iPhone5c, iPhone5s, iPhoneSE
+ (BOOL)is320_568Pt {
  return [UIScreen screenWidth] == 320.f && [UIScreen screenHeight] == 568.f;
}

/// 判断屏幕尺寸为 320×667 pt 设备: iPhone6, iPhone6s, iPhone7, iPhone8,iPhoneSE2
+ (BOOL)is375_667Pt {
  return [UIScreen screenWidth] == 375.f && [UIScreen screenHeight] == 667.f;
}

/// 判断屏幕尺寸为 375×812 pt 设备:iPhoneX, iPhoneXS, iPhone 11 Pro, iPhone12mini
+ (BOOL)is375_812Pt {
  return [UIScreen screenWidth] == 375.f && [UIScreen screenHeight] == 812.f;
}

/// 判断屏幕尺寸为 414×736 pt 设备: iPhone6Plus, iPhone6sPlus, iPhone7Plus, iPhone8Plus
+ (BOOL)is414_736Pt {
  return [UIScreen screenWidth] == 414.f && [UIScreen screenHeight] == 736.f;
}

/// 判断屏幕尺寸为 414×896 pt 设备: iPhoneXR, iPhone 11,iPhoneXS Max, iPhone 11 Pro Max
+ (BOOL)is414_896Pt {
  return [UIScreen screenWidth] == 414.f && [UIScreen screenHeight] == 896.f;
}

/// 判断屏幕尺寸为 390×844 pt 设备: iPhone 12,iPhone 12 Pro
+ (BOOL)is390_844Pt {
  return [UIScreen screenWidth] == 390.f && [UIScreen screenHeight] == 844.f;
}

/// 判断屏幕尺寸为 428×926 pt 设备: iPhone 12 Pro Max
+ (BOOL)is428_926Pt {
  return [UIScreen screenWidth] == 428.f && [UIScreen screenHeight] == 926.f;
}

@end
