//
//  TitleCollectionView.h
//  LRKit
//
//  Created by lirui on 2021/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleCollectionView : UIView

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic, assign) CGFloat cellCornerRadius;

- (instancetype)initWithTitleArray:(NSArray <NSString *> *)titleArray;

@end

NS_ASSUME_NONNULL_END
