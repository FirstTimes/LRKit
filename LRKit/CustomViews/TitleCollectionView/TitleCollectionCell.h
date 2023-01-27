//
//  TitleCollectionCell.h
//  LRKit
//
//  Created by lirui on 2021/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *contentBackgroundColor;

- (void)updateWithTitle:(NSString *)title;
- (void)updateWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont;
- (void)updateWithTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;
- (void)addCornerWithRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
