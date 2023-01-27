//
//  TitleCollectionCell.m
//  LRKit
//
//  Created by lirui on 2021/11/25.
//

#import "TitleCollectionCell.h"
#import <Masonry.h>

@interface TitleCollectionCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

@end

@implementation TitleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)updateWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)updateWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont {
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = titleFont;
}

- (void)updateWithTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    self.titleEdgeInsets = titleEdgeInsets;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleEdgeInsets.top);
        make.left.mas_equalTo(self.titleEdgeInsets.left);
        make.bottom.mas_equalTo(-self.titleEdgeInsets.bottom);
        make.right.mas_equalTo(-self.titleEdgeInsets.right);
    }];
}

- (void)addCornerWithRadius:(CGFloat)cornerRadius {
    self.containerView.layer.cornerRadius = cornerRadius;
    self.containerView.layer.backgroundColor = self.contentBackgroundColor.CGColor;
}

- (void)configureViews {
    self.containerView = [[UIView alloc] init];
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleEdgeInsets.top);
        make.left.mas_equalTo(self.titleEdgeInsets.left);
        make.bottom.mas_equalTo(-self.titleEdgeInsets.bottom);
        make.right.mas_equalTo(-self.titleEdgeInsets.right);
    }];
}

@end
