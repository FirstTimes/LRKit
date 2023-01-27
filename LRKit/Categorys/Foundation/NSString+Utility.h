//
//  NSString+Utility.h
//  LRKit
//
//  Created by lirui on 2021/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utility)

#pragma mark - MD5加密

///md5加密32位小写
+ (NSString *)md5String:(NSString *)string;
///md5加密32位大写
+ (NSString *)MD5String:(NSString *)string;

///md5加密32位小写
- (NSString *)md5String;
///md5加密32位大写
- (NSString *)MD5String;

#pragma mark - Base64编码和解码

///Base64编码
+ (NSString *)base64EncodedString:(NSString *)string;
///Base64解码
+ (NSString *)base64DecodedString:(NSString *)base64String;

///Base64编码
- (NSString *)base64EncodedString;
///Base64解码
- (NSString *)base64DecodedString;

#pragma mark - URL编码和解码

///通用的URL编码，URLQueryAllowedCharacterSet  "#%<>[\]^`{|}
- (NSString *)URLEncodedString;

/**
 指定需要编码的字符集，对其进行URL编码
 ※ URLFragmentAllowedCharacterSet   "#%<>[\]^`{|}
 ※ URLHostAllowedCharacterSet           "#%/<>?@\^`{|}
 ※ URLPasswordAllowedCharacterSet   "#%/:<>?@[\]^`{|}
 ※ URLPathAllowedCharacterSet            "#%;<>?[\]^`{|}
 ※ URLQueryAllowedCharacterSet          "#%<>[\]^`{|}
 ※ URLUserAllowedCharacterSet            "#%/:<>?@[\]^`
*/
- (NSString *)URLEncodedStringWithCharacterSet:(NSCharacterSet *)characterSet;

///自定义指定需要编码的字符集，对其进行URL编码，例如需要处理加号 #%<>[\]^`{|}"]+
- (NSString *)URLEncodedStringWithNeedCodeString:(NSString *)needCodeString;

///通用的URL解码
- (NSString *)URLDecodedString;

#pragma mark - 关于表情符号

///判断是否含有表情符号
+ (BOOL)stringContainsEmoji:(NSString *)string;

///判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;

///去除表情符号
+ (NSString *)clearEmoji:(NSString *)text;

#pragma mark - 计算文本内容的长宽

///根据限定高度、字体大小来获取文本内容的宽度
- (CGFloat)textWidthWithFont:(UIFont *)font height:(CGFloat)height;

///根据限定宽度、字体大小来获取文本内容的高度
- (CGFloat)textHeightWithFont:(UIFont *)font width:(CGFloat)width;

#pragma mark - JSON字符串

///数组转JSON字符串
+ (NSString *)jsonStringWithArray:(NSArray *)array;

///字典转JSON字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

#pragma mark - 常用方法

///判断去除头尾空格和换行后，字符串有效长度是否不为0，有效长度>0是YES，有效长度=0是NO
- (BOOL)isNotBlank;

///判断去除头尾空格和换行后，字符串有效长度是否为0，有效长度=0是YES， 有效长度>0是NO，
+ (BOOL)isBlank:(NSString *)string;

///去除所有的换行
- (NSString *)removeAllLineBreaks;
///去除头尾空格
- (NSString *)removeHeadandTailWhitespace;
///去除头尾空格和所有换行
- (NSString *)removeHeadandTailWhitespaceAndAllLineBreaks;
///去除所有的空格和所有的换行
- (NSString *)removeAllWhitespaceAndAllLineBreaks;

@end

NS_ASSUME_NONNULL_END
