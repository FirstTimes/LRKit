//
//  UIView+Utility.h
//  LRKit
//
//  Created by lirui on 2021/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

struct CGViewCornerRadiis {
    CGFloat topLeft;
    CGFloat topRight;
    CGFloat bottomLeft;
    CGFloat bottomRight;
};
typedef struct CGViewCornerRadiis CGViewCornerRadiis;

CG_INLINE CGViewCornerRadiis
CGViewCornerRadiisMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight) {
    CGViewCornerRadiis cornerRadiis;
    cornerRadiis.topLeft = topLeft;
    cornerRadiis.topRight = topRight;
    cornerRadiis.bottomLeft = bottomLeft;
    cornerRadiis.bottomRight = bottomRight;
    return cornerRadiis;
};

@interface UIView (Utility)

/// 设置部分圆角，统一的圆角半径（设置4个圆角直接设置layer.cornerRadius属性）
- (void)addCornerMask:(CACornerMask)cornerMask withCornerRadius:(CGFloat)cornerRadius;

/// 设置不同半径的圆角，若使用Masonry，先调用 layoutIfNeeded 方法
- (void)addCornerMaskWithCornerRadiis:(CGViewCornerRadiis)cornerRadiis;

@end

NS_ASSUME_NONNULL_END
