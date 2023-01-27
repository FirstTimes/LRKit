//
//  UILabel+VerticalAlignment.h
//  LRKit
//
//  Created by lirui on 2021/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NSVerticalAlignment) {
    NSVerticalAlignmentTop,
    NSVerticalAlignmentMiddle,
    NSVerticalAlignmentBottom,
};

@interface UILabel (VerticalAlignment)

@property (nonatomic, assign) NSVerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
