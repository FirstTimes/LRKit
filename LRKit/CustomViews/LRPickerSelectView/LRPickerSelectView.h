//
//  LRPickerSelectView.h
//  LRKit
//
//  Created by lirui on 2023/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PickerSelectViewConfirmButtonClickedBlock)(NSInteger index, NSString *selectedText);

@interface LRPickerSelectView : UIView

@property (nonatomic, copy) PickerSelectViewConfirmButtonClickedBlock confirmButtonClickedBlock;

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray <NSString *> *)dataArray;
- (void)show;
- (void)selectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
