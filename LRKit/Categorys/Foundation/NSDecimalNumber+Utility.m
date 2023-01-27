//
//  NSDecimalNumber+Utility.m
//  LRKit
//
//  Created by lirui on 2022/2/9.
//

#import "NSDecimalNumber+Utility.h"

@implementation NSDecimalNumber (Utility)

#pragma mark - 常量初始化

+ (NSDecimalNumber *)zeroDecimalNumber {
    return [NSDecimalNumber zero];
}

+ (NSDecimalNumber *)oneDecimalNumber {
    return [NSDecimalNumber one];
}

+ (NSDecimalNumber *)tenDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"10"];
}

+ (NSDecimalNumber *)oneHundredDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"100"];
}

+ (NSDecimalNumber *)oneThousandDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"1000"];
}

+ (NSDecimalNumber *)tenThousandDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"10000"];
}

+ (NSDecimalNumber *)oneHundredThousandDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"100000"];
}

+ (NSDecimalNumber *)oneMillionDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:@"1000000"];
}

#pragma mark - 加法运算

- (NSDecimalNumber *)addDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self decimalNumberByAdding:decimalNumber];
}

- (NSDecimalNumber *)addDecimalNumberString:(NSString *)decimalNumberString {
    return [self decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:decimalNumberString]];
}

- (NSDecimalNumber *)addDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByAdding:decimalNumber withBehavior:handler];
}

- (NSDecimalNumber *)addDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:decimalNumberString] withBehavior:handler];
}

#pragma mark - 减法运算

- (NSDecimalNumber *)subtractDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self decimalNumberBySubtracting:decimalNumber];
}

- (NSDecimalNumber *)subtractDecimalNumberString:(NSString *)decimalNumberString {
    return [self decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:decimalNumberString]];
}

- (NSDecimalNumber *)subtractDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberBySubtracting:decimalNumber withBehavior:handler];
}

- (NSDecimalNumber *)subtractDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:decimalNumberString] withBehavior:handler];
}

#pragma mark - 乘法运算

- (NSDecimalNumber *)multiplyDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self decimalNumberByMultiplyingBy:decimalNumber];
}

- (NSDecimalNumber *)multiplyDecimalNumberString:(NSString *)decimalNumberString {
    return [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:decimalNumberString]];
}

- (NSDecimalNumber *)multiplyDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByMultiplyingBy:decimalNumber withBehavior:handler];
}

- (NSDecimalNumber *)multiplyDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:decimalNumberString] withBehavior:handler];
}

#pragma mark - 除法运算

- (NSDecimalNumber *)divideDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self decimalNumberByDividingBy:decimalNumber];
}

- (NSDecimalNumber *)divideDecimalNumberString:(NSString *)decimalNumberString {
    return [self decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:decimalNumberString]];
}

- (NSDecimalNumber *)divideDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByDividingBy:decimalNumber withBehavior:handler];
}

- (NSDecimalNumber *)divideDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:decimalNumberString] withBehavior:handler];
}

- (NSDecimalNumber *)floorDivideDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundDownHandlerWithScale:scale];
    return [self decimalNumberByDividingBy:decimalNumber withBehavior:handler];
}

- (NSDecimalNumber *)floorDivideDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundDownHandlerWithScale:scale];
    return [self decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:decimalNumberString] withBehavior:handler];
}

#pragma mark - 次方运算

- (NSDecimalNumber *)power:(NSUInteger)power {
    return [self decimalNumberByRaisingToPower:power];
}

- (NSDecimalNumber *)multiplyByPowerOf10:(short)power {
    return [self decimalNumberByMultiplyingByPowerOf10:power];
}

- (NSDecimalNumber *)multiplyByPowerOf10:(short)power scale:(short)scale {
    NSDecimalNumberHandler *handler = [NSDecimalNumber roundPlainHandlerWithScale:scale];
    return [self decimalNumberByMultiplyingByPowerOf10:power withBehavior:handler];
}

#pragma mark - 比较方法

- (BOOL)isEquaToDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self compare:decimalNumber] == NSOrderedSame;
}

- (BOOL)isEquaToDecimalNumberString:(NSString *)decimalNumberString {
    return [self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedSame;
}

- (BOOL)isGreaterThanDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self compare:decimalNumber] == NSOrderedDescending;
}

- (BOOL)isGreaterThanDecimalNumberString:(NSString *)decimalNumberString {
    return [self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedDescending;
}

- (BOOL)isLessThanDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return [self compare:decimalNumber] == NSOrderedAscending;
}

- (BOOL)isLessThanDecimalNumberString:(NSString *)decimalNumberString {
    return [self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedAscending;
}

- (BOOL)isGreaterThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return ([self compare:decimalNumber] == NSOrderedDescending) || ([self compare:decimalNumber] == NSOrderedSame);
}

- (BOOL)isGreaterThanOrEqualToDecimalNumberString:(NSString *)decimalNumberString {
    return ([self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedDescending) || ([self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedSame);
}

- (BOOL)isLessThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber {
    return ([self compare:decimalNumber] == NSOrderedAscending) || ([self compare:decimalNumber] == NSOrderedSame);
}

- (BOOL)isLessThanOrEqualToDecimalNumberString:(NSString *)decimalNumberString {
    return ([self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedAscending) || ([self compare:[NSDecimalNumber decimalNumberWithString:decimalNumberString]] == NSOrderedSame);
}

#pragma mark - Private Methods

/**
 默认采用四舍五入的精度计算处理方式
 RoundingMode : 舍入方式
 ※ `NSRoundPlain`: 四舍五入
 ※ `NSRoundDown`: 只舍不入
 ※ `NSRoundUp`: 只入不舍
 ※ `NSRoundBankers` : 特殊的四舍五入（奇入偶舍），和NSRoundPlain不一样，保留位数的后一位为5时，根据保留位的数字的奇偶性来确定舍入规则，奇数则入，偶数则舍。
 例如：scale = 2，保留2位小数，数字0.235的保留位数的后一位为5，5前面保留位的数字为3，是奇数要进1，结果为0.24。
 如果数字是0.245，5前面保留位的数字为4，是偶数要舍去，结果为0.24。
 scale : 舍入所得的结果值小数点后保留的位数（计算结果保留几位小数）
 raiseOnExactness : 精度错误处理，YES:如果出现错误，将引发异常，NO:忽略错误并将控制权放回给调用者。
 raiseOnOverflow : 溢出错误处理，YES:如果出现错误，将引发异常，NO:忽略错误并将控制权放回给调用者。
 raiseOnUnderflow : 下溢错误处理，YES:如果出现错误，将引发异常，NO:忽略错误并将控制权放回给调用者。
 raiseOnDivideByZero : 除以0的错误处理，YES:如果出现错误，将引发异常，NO:忽略错误并将控制权放回给调用者。
 @return NSDecimalNumberHandler 舍入方式和计算错误处理规则的对象
 */
+ (NSDecimalNumberHandler *)roundPlainHandlerWithScale:(short)scale {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

///采用只舍不入的精度计算处理方式
+ (NSDecimalNumberHandler *)roundDownHandlerWithScale:(short)scale {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

@end
