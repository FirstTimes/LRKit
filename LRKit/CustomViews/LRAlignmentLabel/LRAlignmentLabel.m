//
//  LRAlignmentLabel.m
//  LRKit
//
//  Created by lirui on 2022/3/19.
//

#import "LRAlignmentLabel.h"

@implementation LRAlignmentLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.verticalAlignment = LRVerticalAlignmentMiddle;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.verticalAlignment = LRVerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(LRVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case LRVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case LRVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case LRVerticalAlignmentMiddle:
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
