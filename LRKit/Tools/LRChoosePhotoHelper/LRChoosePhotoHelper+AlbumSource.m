//
//  LRChoosePhotoHelper+AlbumSource.m
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import "LRChoosePhotoHelper+AlbumSource.h"

@implementation LRChoosePhotoHelper (AlbumSource)

#pragma mark - Public Methods

- (void)createAndShowAlbumViewOnViewController:(UIViewController *)viewController {
  TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxChooseCount delegate:self];
  imagePickerController.allowTakeVideo = NO;
  imagePickerController.allowPickingGif = NO;
  imagePickerController.allowTakePicture = NO;
  imagePickerController.allowPickingVideo = NO;
  imagePickerController.showSelectedIndex = YES;
  imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;

  [viewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
  self.chooseFromAlbumCompletion == nil ?: self.chooseFromAlbumCompletion(photos);
  
  [self resetAlbumChooseConfigWhenCompletionOrCancel];
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
  [self resetAlbumChooseConfigWhenCompletionOrCancel];
}

#pragma mark - Private Methods

- (void)resetAlbumChooseConfigWhenCompletionOrCancel {
  self.maxChooseCount = 0;
  self.chooseFromAlbumCompletion = nil;
}

@end
