//
//  LRMarginLabel.m
//  LRKit
//
//  Created by lirui on 2022/6/7.
//

#import "LRMarginLabel.h"

@implementation LRMarginLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentInset = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentInset = UIEdgeInsetsZero;
    }
    return self;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.x -= _contentInset.left;
    textRect.origin.y -= _contentInset.top;
    textRect.size.width += _contentInset.left + _contentInset.right;
    textRect.size.height += _contentInset.top + _contentInset.bottom;
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _contentInset)];
}

@end
