//
//  UIScreen+Utility.h
//  LRKit
//
//  Created by lirui on 2021/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (Utility)

///屏幕尺寸大小
+ (CGSize)screenSize;
///屏幕宽度
+ (CGFloat)screenWidth;
///屏幕高度
+ (CGFloat)screenHeight;
///屏幕分辨率比例
+ (CGFloat)screenScale;
///顶部安全距离
//+ (CGFloat)topSafeAreaSpace;
///底部安全距离
+ (CGFloat)bottomSafeAreaSpace;
///是否是经典屏幕(非刘海屏)，YES表示是经典屏幕(非刘海屏)，NO表示是刘海屏
+ (BOOL)isNormalScreen;
///导航栏高度
+ (CGFloat)navigationBarHeight;
///状态栏和导航栏总高度
+ (CGFloat)statusAndNavigationBarHeight;
///Tabbar高度
+ (CGFloat)tabBarHeight;

///320×480 pt 屏幕尺寸 设备: iPhone4, iPhone4s
+ (CGSize)sizeOf320_480Pt;
///320×568 pt 屏幕尺寸 设备: iPhone5, iPhone5c, iPhone5s, iPhoneSE
+ (CGSize)sizeOf320_568Pt;
///375×667 pt 屏幕尺寸 设备: iPhone6, iPhone6s, iPhone7, iPhone8,iPhoneSE2
+ (CGSize)sizeOf375_667Pt;
///375×812 pt 屏幕尺寸 设备:iPhoneX, iPhoneXS, iPhone 11 Pro, iPhone12mini
+ (CGSize)sizeOf375_812Pt;
///414×736 pt 屏幕尺寸 设备: iPhone6Plus, iPhone6sPlus, iPhone7Plus, iPhone8Plus
+ (CGSize)sizeOf414_736Pt;
///414×896 pt 屏幕尺寸 设备: iPhoneXR, iPhone 11,iPhoneXS Max, iPhone 11 Pro Max
+ (CGSize)sizeOf414_896Pt;
///390×844 pt 屏幕尺寸 设备: iPhone 12,iPhone 12 Pro
+ (CGSize)sizeOf390_844Pt;
///428×926 pt 屏幕尺寸 设备: iPhone 12 Pro Max
+ (CGSize)sizeOf428_926Pt;

@end

NS_ASSUME_NONNULL_END
