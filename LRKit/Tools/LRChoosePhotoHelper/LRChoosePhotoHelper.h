//
//  LRChoosePhotoHelper.h
//  ZJFProject
//
//  Created by lirui on 2022/7/6.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^LRChooseFromCameraCompletion)(UIImage *image);
typedef void (^LRChooseFromAlbumCompletion)(NSArray<UIImage *> *images);

@interface LRChoosePhotoHelper : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate>

// 相机
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, copy) _Nullable LRChooseFromCameraCompletion chooseFromCameraCompletion;

// 相册
@property (nonatomic, assign) NSInteger maxChooseCount;
@property (nonatomic, copy) _Nullable LRChooseFromAlbumCompletion chooseFromAlbumCompletion;

/**
 从相机选择图片 (仅支持单张)
 ⚠️: `相机权限`校验和弹框显示已经在内部实现, 开发者无需关心权限问题
 @param viewController 模态的目标ViewController
 @param allowEdit 图片是否允许编辑
 @param completion 图片选择完成回调
 */
+ (void)chooseFromCameraOnViewController:(UIViewController *)viewController allowEdit:(BOOL)allowEdit completion:(LRChooseFromCameraCompletion)completion;


/**
 从相册选择图片 (支持多张)
 ⚠️: `相册权限`校验和弹框显示已经在内部实现, 开发者无需关心权限问题
 @param viewController 模态的目标ViewController
 @param maxCount 可以选取的最大数量
 @param completion 图片选择完成回调
 */
+ (void)chooseFromAlbumOnViewController:(UIViewController *)viewController maxCount:(NSInteger)maxCount completion:(LRChooseFromAlbumCompletion)completion;

@end

NS_ASSUME_NONNULL_END
