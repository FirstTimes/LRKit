//
//  LRConstraint.m
//  LRKit
//
//  Created by lirui on 2023/1/8.
//

#import "LRConstraint.h"

static const CGFloat HUGGING_PRIORITY_DEFAULT = 251;
static const CGFloat COMPRESSION_PRIORITY_DEFAULT = 750;

@implementation LRConstraint

- (void)awakeFromNib {
  [super awakeFromNib];
  
  if (self.constant == 1) {
    self.constant = 1 / [UIScreen mainScreen].scale;
  }
}

#pragma mark LabelPriority

+ (void)labelsHorizontalPriorityResistFromHighToLow:(NSArray<UILabel *> *)labels {
  [labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) {
    [label setContentHuggingPriority:HUGGING_PRIORITY_DEFAULT - index forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentCompressionResistancePriority:COMPRESSION_PRIORITY_DEFAULT - index forAxis:UILayoutConstraintAxisHorizontal];
  }];
}

+ (void)labelsVerticalPriorityResistFromHighToLow:(NSArray<UILabel *> *)labels {
  [labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) {
    [label setContentHuggingPriority:HUGGING_PRIORITY_DEFAULT - index forAxis:UILayoutConstraintAxisVertical];
    [label setContentCompressionResistancePriority:COMPRESSION_PRIORITY_DEFAULT - index forAxis:UILayoutConstraintAxisVertical];
  }];
}

@end
