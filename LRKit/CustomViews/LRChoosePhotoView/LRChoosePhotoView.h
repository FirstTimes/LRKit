//
//  LRChoosePhotoView.h
//  LRKit
//
//  Created by lirui on 2023/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ///相机
    LRChoosePhotoWayTypeCamera = 0,
    ///相册
    LRChoosePhotoWayTypeAlbum = 1,
} LRChoosePhotoWayType;

typedef void (^ChoosePhotoBlock)(LRChoosePhotoWayType choosePhotoWayType);

@interface LRChoosePhotoView : UIView

@property (nonatomic, copy) ChoosePhotoBlock choosePhotoBlock;

- (instancetype)initWithTitleArray:(NSArray *)titleArray;
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
