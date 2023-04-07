//
//  LRTextInputView.h
//  LRKit
//
//  Created by lirui on 2023/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextInputViewConfirmButtonClickedBlock)(NSString *text);

@interface LRTextInputView : UIView

@property (nonatomic, copy) TextInputViewConfirmButtonClickedBlock confirmButtonClickedBlock;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title wordSum:(NSUInteger)wordSum leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle viewHeight:(CGFloat)viewHeight;
- (void)updateTextViewPlaceholder:(NSString *)placeholder;
- (void)updateTextViewWordSum:(NSUInteger)wordSum;
- (void)updateTextViewText:(NSString *)text;
- (void)show;

@end

NS_ASSUME_NONNULL_END
