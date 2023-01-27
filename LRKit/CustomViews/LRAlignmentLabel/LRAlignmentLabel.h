//
//  LRAlignmentLabel.h
//  LRKit
//
//  Created by lirui on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LRVerticalAlignment) {
    ///顶部对齐
    LRVerticalAlignmentTop,
    ///中间对齐
    LRVerticalAlignmentMiddle,
    ///底部对齐
    LRVerticalAlignmentBottom
};

@interface LRAlignmentLabel : UILabel

@property (nonatomic, assign) LRVerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
