//
//  UIImage+Utility.m
//  LRKit
//
//  Created by lirui on 2023/4/4.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (UIImage *)backWhiteImage {
    return [UIImage imageNamed:@"common_back_white"];
}

+ (UIImage *)backBlackImage {
    return [UIImage imageNamed:@"common_back_black"];
}

// 等比率缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 裁剪图片
- (UIImage *)cutImage:(UIImage *)image WithGect:(CGSize)size {
    //由中心点来截取Size范围的图片
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat viewWidth = size.width;
    CGFloat viewHeight = size.height;
    CGRect cutRect = CGRectMake((imageWidth-viewWidth)/2, (imageHeight-viewHeight)/2, viewWidth, viewHeight);
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(image.CGImage, cutRect);
    CGRect cutBounds = CGRectMake(0, 0, CGImageGetWidth(cutImageRef), CGImageGetHeight(cutImageRef));
    UIGraphicsBeginImageContext(cutBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutBounds, cutImageRef);
    UIImage* cutImage = [UIImage imageWithCGImage:cutImageRef];
    UIGraphicsEndImageContext();
    return cutImage;
}

// 旋转图片
- (UIImage *)rotationImage:(UIImage *)image withOrientation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPicture = UIGraphicsGetImageFromCurrentImageContext();
    return newPicture;
}

@end
