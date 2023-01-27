//
//  UIView+Utility.m
//  LRKit
//
//  Created by lirui on 2021/11/22.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)

#pragma mark - 圆角

- (void)addCornerMask:(CACornerMask)cornerMask withCornerRadius:(CGFloat)cornerRadius {
    if (@available(iOS 11.0, *)) {
        self.layer.maskedCorners = cornerMask;
        self.layer.cornerRadius = cornerRadius;
    } else {
        [self addCornerMaskWithCornerRadiis:CGViewCornerRadiisMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
    }
}

- (void)addCornerMaskWithCornerRadiis:(CGViewCornerRadiis)cornerRadiis {
    [self layoutIfNeeded];
    
    const CGFloat minX = CGRectGetMinX(self.bounds);
    const CGFloat minY = CGRectGetMinY(self.bounds);
    const CGFloat maxX = CGRectGetMaxX(self.bounds);
    const CGFloat maxY = CGRectGetMaxY(self.bounds);
    
    const CGFloat topLeftCenterX = minX + cornerRadiis.topLeft;
    const CGFloat topLeftCenterY = minY + cornerRadiis.topLeft;
    const CGFloat topRightCenterX = maxX - cornerRadiis.topRight;
    const CGFloat topRightCenterY = minY + cornerRadiis.topRight;
    const CGFloat bottomLeftCenterX = minX + cornerRadiis.bottomLeft;
    const CGFloat bottomLeftCenterY = maxY - cornerRadiis.bottomLeft;
    const CGFloat bottomRightCenterX = maxX - cornerRadiis.bottomRight;
    const CGFloat bottomRightCenterY = maxY - cornerRadiis.bottomRight;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, topLeftCenterX, topLeftCenterY,cornerRadiis.topLeft, M_PI, 3 * M_PI_2, NO);
    CGPathAddArc(path, NULL, topRightCenterX , topRightCenterY, cornerRadiis.topRight, 3 * M_PI_2, 0, NO);
    CGPathAddArc(path, NULL, bottomRightCenterX, bottomRightCenterY, cornerRadiis.bottomRight,0, M_PI_2, NO);
    CGPathAddArc(path, NULL, bottomLeftCenterX, bottomLeftCenterY, cornerRadiis.bottomLeft, M_PI_2,M_PI, NO);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path;
    CGPathRelease(path);
    self.layer.mask = shapeLayer;
}

@end
