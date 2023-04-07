//
//  UIImage+Utility.h
//  LRKit
//
//  Created by lirui on 2023/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utility)

+ (UIImage *)backWhiteImage;
+ (UIImage *)backBlackImage;

///等比率缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
///从图片中心点截取Size范围的图片
- (UIImage *)cutImage:(UIImage *)image WithGect:(CGSize)size;
///旋转图片
- (UIImage *)rotationImage:(UIImage *)image withOrientation:(UIImageOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
