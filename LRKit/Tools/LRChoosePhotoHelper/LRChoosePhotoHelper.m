//
//  LRChoosePhotoHelper.m
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import "LRChoosePhotoHelper.h"
#import "LRChoosePhotoHelper+CameraSource.h"
#import "LRChoosePhotoHelper+AlbumSource.h"
#import "UIApplication+Utility.h"
#import "UIDevice+Utility.h"

static LRChoosePhotoHelper *choosePhotoHelper = nil;

@implementation LRChoosePhotoHelper

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    choosePhotoHelper = [[LRChoosePhotoHelper alloc] init];
  });

  return choosePhotoHelper;
}

+ (void)chooseFromCameraOnViewController:(UIViewController *)viewController allowEdit:(BOOL)allowEdit completion:(LRChooseFromCameraCompletion)completion {
    [UIDevice requestPermissionsForCaptureWithCompletion:^(BOOL isAllow) {
        if (isAllow) {
            LRChoosePhotoHelper *choosePhotoHelper = [LRChoosePhotoHelper sharedInstance];
            choosePhotoHelper.allowEdit = allowEdit;
            choosePhotoHelper.chooseFromCameraCompletion = completion;
            [choosePhotoHelper createAndShowCameraViewOnViewController:viewController];
        } else {
            [self nonePermissionsAlertForCamera];
            
        }
    }];
}

+ (void)chooseFromAlbumOnViewController:(UIViewController *)viewController maxCount:(NSInteger)maxCount completion:(LRChooseFromAlbumCompletion)completion {
    [UIDevice requestPermissionsForAlbumWithCompletion:^(BOOL isAllow) {
        if (isAllow) {
        LRChoosePhotoHelper *choosePhotoHelper = [LRChoosePhotoHelper sharedInstance];
        choosePhotoHelper.maxChooseCount = maxCount;
        choosePhotoHelper.chooseFromAlbumCompletion = completion;
        [choosePhotoHelper createAndShowAlbumViewOnViewController:viewController];
            
        } else {
            [self nonePermissionsAlertForAlbum];
        }
    }];
}

#pragma mark - Permission Alert Methods

+ (void)nonePermissionsAlertForCamera {
    [self showAlertViewWithTitle:@"" content:@"未开启相机权限, 请前往设置界面设置" leftButtonTitle:@"取消" rightButtonTitle:@"确定" leftButtonClickedBlock:^{
        
    } rightButtonClickedBlock:^{
        [UIApplication openSetting];
    }];
}

+ (void)nonePermissionsAlertForAlbum {
    [self showAlertViewWithTitle:@"" content:@"未开启相册权限, 请前往设置界面设置" leftButtonTitle:@"取消" rightButtonTitle:@"确定" leftButtonClickedBlock:^{
        
    } rightButtonClickedBlock:^{
        [UIApplication openSetting];
    }];
}

+ (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle
        leftButtonClickedBlock:(void (^)(void))leftButtonClickedBlock rightButtonClickedBlock:(void (^)(void))rightButtonClickedBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (leftButtonClickedBlock) {
            leftButtonClickedBlock();
        }
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (rightButtonClickedBlock) {
            rightButtonClickedBlock();
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIViewController *viewController = [[window rootViewController] presentedViewController];
    if (viewController == nil) {
        viewController = window.rootViewController;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
