//
//  UIColor+Utility.m
//  LRKit
//
//  Created by lirui on 2021/11/1.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor*)randomColor {
    uint32_t colorRangeMax = 256;
    float red = (float)arc4random_uniform(colorRangeMax) / (colorRangeMax-1);
    float green = (float)arc4random_uniform(colorRangeMax) / (colorRangeMax-1);
    float blue = (float)arc4random_uniform(colorRangeMax) / (colorRangeMax-1);

    UIColor * randColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
    return randColor;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
  return [UIColor colorWithHexString:hexString alpha:1.f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
  
  CGFloat colorAlpha, red, blue, green;
  switch ([colorString length]) {
    case 3:  { // #RGB
      colorAlpha = alpha;
      red   = [self colorComponentFrom: colorString start: 0 length: 1];
      green = [self colorComponentFrom: colorString start: 1 length: 1];
      blue  = [self colorComponentFrom: colorString start: 2 length: 1];
    }
      break;
      
    case 4: { // #ARGB
      colorAlpha = [self colorComponentFrom: colorString start: 0 length: 1];
      red   = [self colorComponentFrom: colorString start: 1 length: 1];
      green = [self colorComponentFrom: colorString start: 2 length: 1];
      blue  = [self colorComponentFrom: colorString start: 3 length: 1];
    }
      break;
      
    case 6: { // #RRGGBB
      colorAlpha = alpha;
      red   = [self colorComponentFrom: colorString start: 0 length: 2];
      green = [self colorComponentFrom: colorString start: 2 length: 2];
      blue  = [self colorComponentFrom: colorString start: 4 length: 2];
    }
      break;
      
    case 8: { // #AARRGGBB
      colorAlpha = [self colorComponentFrom: colorString start: 0 length: 2];
      red   = [self colorComponentFrom: colorString start: 2 length: 2];
      green = [self colorComponentFrom: colorString start: 4 length: 2];
      blue  = [self colorComponentFrom: colorString start: 6 length: 2];
    }
      break;
      
    default:
      return [UIColor blackColor];
      break;
  }
  
  return [UIColor colorWithRed:red green:green blue:blue alpha:colorAlpha];
}

#pragma mark - Private Methods

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
  NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
  NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
  unsigned hexComponent;
  [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
  
  return hexComponent / 255.0;
}

@end
