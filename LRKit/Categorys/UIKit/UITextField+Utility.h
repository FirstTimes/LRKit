//
//  UITextField+Utility.h
//  LRKit
//
//  Created by lirui on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Utility)

+ (BOOL)textFieldKeepTwoDecimalPlacesWithShouldChangeCharactersInRange:(NSRange)range string:(NSString *)string textField:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
