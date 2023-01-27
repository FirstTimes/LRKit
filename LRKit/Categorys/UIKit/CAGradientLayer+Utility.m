//
//  CAGradientLayer+Utility.m
//  zjfSeller
//
//  Created by lirui on 2021/4/1.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import "CAGradientLayer+Utility.h"
#import "UIColor+Utility.h"

@implementation CAGradientLayer (Utility)

+ (CAGradientLayer *)gradientLayerHorizontalDirectionWithStartColorHex:(NSString *)startColorHex endColorHex:(NSString *)endColorHex {
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:startColorHex].CGColor, (__bridge id)[UIColor colorWithHexString:endColorHex].CGColor];
  gradientLayer.locations = @[@(0), @(1)];
  gradientLayer.startPoint = CGPointMake(0, 0.5);
  gradientLayer.endPoint = CGPointMake(1, 0.5);
  
  return gradientLayer;
}

+ (CAGradientLayer *)gradientLayerVerticalDirectionWithStartColorHex:(NSString *)startColorHex endColorHex:(NSString *)endColorHex {
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:startColorHex].CGColor, (__bridge id)[UIColor colorWithHexString:endColorHex].CGColor];
  gradientLayer.locations = @[@(0), @(1)];
  gradientLayer.startPoint = CGPointMake(0.5, 0);
  gradientLayer.endPoint = CGPointMake(0.5, 1);
  
  return gradientLayer;
}

@end
