//
//  LRChoosePhotoHelper+CameraSource.m
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import "LRChoosePhotoHelper+CameraSource.h"

@implementation LRChoosePhotoHelper (CameraSource)

#pragma mark - Public Methods

- (void)createAndShowCameraViewOnViewController:(UIViewController *)viewController {
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  imagePickerController.allowsEditing = self.allowEdit;
  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
  
  [viewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
  [picker dismissViewControllerAnimated:YES completion:nil];
  
  self.chooseFromCameraCompletion == nil ?: self.chooseFromCameraCompletion(image);
  [self resetCameraChooseConfigWhenCompletionOrCancel];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
  [self resetCameraChooseConfigWhenCompletionOrCancel];
}

#pragma mark - Private Methods

- (void)resetCameraChooseConfigWhenCompletionOrCancel {
  self.allowEdit = NO;
  self.chooseFromCameraCompletion = nil;
}

@end
