//
//  UIFont+Utility.m
//  zjfSeller
//
//  Created by lirui on 2021/4/1.
//  Copyright © 2021 zhaojiafang. All rights reserved.
//

#import "UIFont+Utility.h"

@implementation UIFont (Utility)

+ (instancetype)pingFangRegular:(CGFloat)size {
  return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+ (instancetype)pingFangSemibold:(CGFloat)size {
  return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

+ (instancetype)pingFangMedium:(CGFloat)size {
  return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

+ (instancetype)helvetica:(CGFloat)size {
  return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (instancetype)helveticaBold:(CGFloat)size {
  return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (instancetype)helveticaMedium:(CGFloat)size {
  return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (instancetype)helveticaCondensedBold:(CGFloat)size {
  return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:size];
}


@end
