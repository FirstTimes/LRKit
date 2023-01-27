//
//  UITextField+Utility.m
//  LRKit
//
//  Created by lirui on 2022/6/6.
//

#import "UITextField+Utility.h"

@implementation UITextField (Utility)

+ (BOOL)textFieldKeepTwoDecimalPlacesWithShouldChangeCharactersInRange:(NSRange)range string:(NSString *)string textField:(UITextField *)textField {
    BOOL isHasPoint = YES;
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHasPoint = NO;
    }
    
    if ([string length] > 0) {
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            //首字母不能为小数点
            if ([textField.text length] == 0){
                if (single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            if ([textField.text length] == 1 && [textField.text isEqualToString:@"0"]) {
                if (single != '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
           
            if (single == '.') {
                if (!isHasPoint) { //text中还没有小数点
                    isHasPoint = YES;
                    return YES;
                } else {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            } else {
                if (isHasPoint) { //存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    NSInteger tt = range.location - ran.location;
                    if (tt <= 2){
                        return YES;
                    } else {
                        return NO;
                    }
                } else {
                    return YES;
                }
            }
        } else {//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    } else {
        return YES;
    }
}

@end
