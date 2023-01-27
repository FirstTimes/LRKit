//
//  UIDevice+Utility.m
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import "UIDevice+Utility.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>

@implementation UIDevice (Utility)

+ (void)requestPermissionsForAlbumWithCompletion:(void (^)(BOOL isAllow))completion {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL hasAuthorized = (status == PHAuthorizationStatusAuthorized);
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(hasAuthorized);
            });
        }
    }];
}

+ (void)requestPermissionsForCaptureWithCompletion:(void (^)(BOOL isAllow))completion {
    if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(granted);
            });
        }];
    }
}

@end
