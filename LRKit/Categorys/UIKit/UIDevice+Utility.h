//
//  UIDevice+Utility.h
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Utility)

///询问相册权限
+ (void)requestPermissionsForAlbumWithCompletion:(void (^)(BOOL isAllow))completion;
///询问相机权限
+ (void)requestPermissionsForCaptureWithCompletion:(void (^)(BOOL isAllow))completion;

@end

NS_ASSUME_NONNULL_END
