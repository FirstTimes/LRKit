//
//  NSString+Utility.m
//  LRKit
//
//  Created by lirui on 2021/11/26.
//

#import "NSString+Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utility)

#pragma mark - MD5加密

+ (NSString *)md5String:(NSString *)string {
    return [self md5EncryptString:string needCapital:NO];
}

+ (NSString *)MD5String:(NSString *)string {
    return [self md5EncryptString:string needCapital:YES];
}

///md5加密，加密结果是否需要大写
+ (NSString *)md5EncryptString:(NSString *)string needCapital:(BOOL)isCapital {
    NSString *format = isCapital ? @"%02X" : @"%02x";
    
    const char *input = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
      [digest appendFormat:format, result[i]];
    }

    return digest;
}

- (NSString *)md5String {
    return [self md5EncryptNeedCapital:NO];
}

- (NSString *)MD5String {
    return [self md5EncryptNeedCapital:YES];
}

- (NSString *)md5EncryptNeedCapital:(BOOL)isCapital {
    NSString *format = isCapital ? @"%02X" : @"%02x";
    
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
      [digest appendFormat:format, result[i]];
    }

    return digest;
}

#pragma mark - Base64编码和解码

+ (NSString *)base64EncodedString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)base64DecodedString:(NSString *)base64String {
  NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
  NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
  return string;
}

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)base64DecodedString {
  NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
  NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
  return string;
}

#pragma mark - URL编码和解码

- (NSString *)URLEncodedString {
    NSCharacterSet *characterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)URLEncodedStringWithCharacterSet:(NSCharacterSet *)characterSet {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)URLEncodedStringWithNeedCodeString:(NSString *)needCodeString {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:needCodeString] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)URLDecodedString {
    return [self stringByRemovingPercentEncoding];
}

#pragma mark - 关于表情符号

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
               returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
      }
    }];
    return returnValue;
}

//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

//去除表情
+ (NSString *)clearEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

#pragma mark - 计算文本内容的长宽

- (CGFloat)textWidthWithFont:(UIFont *)font height:(CGFloat)height {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize textSize = CGSizeZero;
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(textSize.width);
}

- (CGFloat)textHeightWithFont:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize textSize = CGSizeZero;
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(textSize.height);
}

#pragma mark - JSON字符串

+ (NSString *)jsonStringWithArray:(NSArray *)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutableJsonString = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格和换行符
    NSRange range = NSMakeRange(0, jsonString.length);
    [mutableJsonString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range1 = NSMakeRange(0, mutableJsonString.length);
    [mutableJsonString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range1];
    return [NSString stringWithString:mutableJsonString];
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutableJsonString = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格和换行符
    NSRange range = NSMakeRange(0, jsonString.length);
    [mutableJsonString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range1 = NSMakeRange(0, mutableJsonString.length);
    [mutableJsonString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range1];
    return [NSString stringWithString:mutableJsonString];
}

#pragma mark - 常用方法

- (BOOL)isNotBlank {
    BOOL isNotBlank = NO;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string = [self stringByTrimmingCharactersInSet:whitespace];
    if ([string length] > 0) {
        isNotBlank = YES;
    }
    return isNotBlank;
}

+ (BOOL)isBlank:(NSString *)string {
    BOOL isBlank = YES;
    if (!string || [string isKindOfClass:[NSNull class]]) {
        isBlank = YES;
    } else {
        isBlank = ![string isNotBlank];
    }
    return isBlank;
}

- (NSString *)removeAllLineBreaks {
    NSString *result = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
}

- (NSString *)removeHeadandTailWhitespace {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
    NSString *result = [self stringByTrimmingCharactersInSet:whitespace];
    return result;
}

- (NSString *)removeHeadandTailWhitespaceAndAllLineBreaks {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
    NSString *result = [self stringByTrimmingCharactersInSet:whitespace];
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
}

- (NSString *)removeAllWhitespaceAndAllLineBreaks {
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
}

@end
