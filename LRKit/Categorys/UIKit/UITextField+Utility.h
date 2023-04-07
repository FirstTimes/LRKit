//
//  UITextField+Utility.h
//  LRKit
//
//  Created by lirui on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Utility)

///数字输入框保留两位小数
+ (BOOL)textFieldKeepTwoDecimalPlacesWithShouldChangeCharactersInRange:(NSRange)range string:(NSString *)string textField:(UITextField *)textField;

///输入框允许输入最大字符串长度
+ (BOOL)textfieldPermitMaxLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range string:(NSString *)string textField:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
