//
//  NSDecimalNumber+Utility.h
//  LRKit
//
//  Created by lirui on 2022/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (Utility)

#pragma mark - 常量

///精度数0.0
+ (NSDecimalNumber *)zeroDecimalNumber;
///精度数1.0
+ (NSDecimalNumber *)oneDecimalNumber;
///精度数10.0
+ (NSDecimalNumber *)tenDecimalNumber;
///精度数100.0
+ (NSDecimalNumber *)oneHundredDecimalNumber;
///精度数1000.0
+ (NSDecimalNumber *)oneThousandDecimalNumber;
///精度数10000.0
+ (NSDecimalNumber *)tenThousandDecimalNumber;
///精度数100000.0
+ (NSDecimalNumber *)oneHundredThousandDecimalNumber;
///精度数1000000.0
+ (NSDecimalNumber *)oneMillionDecimalNumber;

#pragma mark - 运算方法

///通过精度数进行加法运算
- (NSDecimalNumber *)addDecimalNumber:(NSDecimalNumber *)decimalNumber;
///通过精度数的字符串进行加法运算
- (NSDecimalNumber *)addDecimalNumberString:(NSString *)decimalNumberString;
///通过精度数进行加法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)addDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale;
///通过精度数的字符串进行加法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)addDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale;

///通过精度数进行减法运算
- (NSDecimalNumber *)subtractDecimalNumber:(NSDecimalNumber *)decimalNumber;
///通过精度数的字符串进行减法运算
- (NSDecimalNumber *)subtractDecimalNumberString:(NSString *)decimalNumberString;
///通过精度数进行减法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)subtractDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale;
///通过精度数的字符串进行减法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)subtractDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale;

///通过精度数进行乘法运算
- (NSDecimalNumber *)multiplyDecimalNumber:(NSDecimalNumber *)decimalNumber;
///通过精度数的字符串进行乘法运算
- (NSDecimalNumber *)multiplyDecimalNumberString:(NSString *)decimalNumberString;
///通过精度数进行乘法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)multiplyDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale;
///通过精度数的字符串进行乘法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)multiplyDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale;

///通过精度数进行除法运算
- (NSDecimalNumber *)divideDecimalNumber:(NSDecimalNumber *)decimalNumber;
///通过精度数的字符串进行除法运算
- (NSDecimalNumber *)divideDecimalNumberString:(NSString *)decimalNumberString;
///通过精度数进行除法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)divideDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale;
///通过精度数的字符串进行除法运算 scale : 舍入所得的结果值小数点后保留的位数，例如scale为2，计算结果保留2位小数
- (NSDecimalNumber *)divideDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale;
///通过精度数进行除法运算，计算结果只舍不入
- (NSDecimalNumber *)floorDivideDecimalNumber:(NSDecimalNumber *)decimalNumber scale:(short)scale;
///通过精度数的字符串进行除法运算，计算结果只舍不入
- (NSDecimalNumber *)floorDivideDecimalNumberString:(NSString *)decimalNumberString scale:(short)scale;

///某精度数的幂
- (NSDecimalNumber *)power:(NSUInteger)power;
///乘以10的几次幂
- (NSDecimalNumber *)multiplyByPowerOf10:(short)power;
///乘以10的几次幂 scale : 舍入所得的结果值小数点后保留的位数
- (NSDecimalNumber *)multiplyByPowerOf10:(short)power scale:(short)scale;

#pragma mark - 比较方法

///= 相等于某精度数
- (BOOL)isEquaToDecimalNumber:(NSDecimalNumber *)decimalNumber;
///= 相等于某精度数
- (BOOL)isEquaToDecimalNumberString:(NSString *)decimalNumberString;

///> 大于某精度数
- (BOOL)isGreaterThanDecimalNumber:(NSDecimalNumber *)decimalNumber;
///> 大于某精度数
- (BOOL)isGreaterThanDecimalNumberString:(NSString *)decimalNumberString;

///< 小于某精度数
- (BOOL)isLessThanDecimalNumber:(NSDecimalNumber *)decimalNumber;
///< 小于某精度数
- (BOOL)isLessThanDecimalNumberString:(NSString *)decimalNumberString;

///<= 大于等于某精度数
- (BOOL)isGreaterThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber;
///<= 大于等于某精度数
- (BOOL)isGreaterThanOrEqualToDecimalNumberString:(NSString *)decimalNumberString;

///<= 小于等于某精度数
- (BOOL)isLessThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber;
///<= 小于等于某精度数
- (BOOL)isLessThanOrEqualToDecimalNumberString:(NSString *)decimalNumberString;

@end

NS_ASSUME_NONNULL_END
