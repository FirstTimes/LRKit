//
//  UILabel+VerticalAlignment.m
//  LRKit
//
//  Created by lirui on 2021/11/29.
//

#import "UILabel+VerticalAlignment.h"
#import "objc/runtime.h"

@implementation UILabel (VerticalAlignment)

static NSString *verticalAlignmentTKey = @"verticalAlignmentKey";

+ (void)load {
    //有问题不使用
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//
//        SEL originalSelector = @selector(textRectForBounds:limitedToNumberOfLines:);
//        SEL swizzledSelector = @selector(cover_textRectForBounds:limitedToNumberOfLines:);
//
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//        if (didAddMethod) {
//            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
}

- (void)setVerticalAlignment:(NSVerticalAlignment)verticalAlignment{
    objc_setAssociatedObject(self, &verticalAlignmentTKey, @(verticalAlignment), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsDisplay];
}

- (NSVerticalAlignment)verticalAlignment {
    return [objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(verticalAlignmentTKey)) integerValue];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = NSVerticalAlignmentMiddle;
    }
    return self;
}

//- (CGRect)cover_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
//    CGRect textRect = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
//    switch (self.verticalAlignment) {
//        case NSVerticalAlignmentTop:
//            textRect.origin.y = bounds.origin.y;
//            break;
//        case NSVerticalAlignmentBottom:
//            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
//            break;
//        case NSVerticalAlignmentMiddle:
//        default:
//            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
//            break;
//    }
//    return textRect;
//}

//- (CGRect)adjustTextRect:(CGRect)textRect {
//    CGRect actualTextRect = textRect;
//    switch (self.verticalAlignment) {
//        case NSVerticalAlignmentTop:
//            actualTextRect.origin.y = textRect.origin.y;
//            break;
//        case NSVerticalAlignmentBottom:
//            actualTextRect.origin.y = textRect.origin.y + textRect.size.height - actualTextRect.size.height;
//            break;
//        case NSVerticalAlignmentMiddle:
//            // Fall through.
//        default:
//            actualTextRect.origin.y = textRect.origin.y + (textRect.size.height - actualTextRect.size.height) / 2.0;
//    }
//    return actualTextRect;
//}
//
//- (void)cover_drawTextInRect:(CGRect)rect {
//    CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
//    CGRect actualTextRect = [self adjustTextRect:textRect];
//    [self cover_drawTextInRect:actualTextRect];
//}

@end
