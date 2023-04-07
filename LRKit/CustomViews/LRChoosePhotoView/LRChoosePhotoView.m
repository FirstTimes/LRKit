//
//  LRChoosePhotoView.m
//  LRKit
//
//  Created by lirui on 2023/4/6.
//

#import "LRChoosePhotoView.h"
#import "UIScreen+Utility.h"

@interface LRChoosePhotoView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation LRChoosePhotoView

- (instancetype)initWithTitleArray:(NSArray *)titleArray {
    self = [super init];
    if (self) {
        self.titleArray = [NSArray arrayWithArray:titleArray];
        [self configureViews];
    }
    return self;
}

#pragma mark - Action Methods

- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)titleButtonClicked:(UIButton *)button {
    NSInteger index = button.tag;
    if (self.choosePhotoBlock) {
        self.choosePhotoBlock(index);
    }
}

#pragma mark - Private Methods

- (void)configureViews {
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.4];
    [self configureBgView];
    [self configureCancelButton];
    [self configureTitleView];
}

- (void)configureBgView {
    self.bgView = [[UIView alloc] init];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.bgView addGestureRecognizer:closeTap];
}

- (void)configureCancelButton {
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorWithHexString:@"#FF3939"] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont pingFangMedium:18];
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    self.cancelButton.layer.cornerRadius = 20;
    self.cancelButton.layer.masksToBounds = YES;
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(70);
        make.bottom.mas_equalTo(-10-[UIScreen bottomSafeAreaSpace]);
    }];
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureTitleView {
    CGFloat titleButtonHeight = 70;
    
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.layer.cornerRadius = 20;
    self.titleView.layer.masksToBounds = YES;
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(self.cancelButton.mas_top).offset(-10);
        make.height.mas_equalTo(titleButtonHeight*self.titleArray.count);
    }];
    
    [self.titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat titleButtonTop = titleButtonHeight * idx;
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.tag = idx;
        [titleButton setTitle:title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont pingFangRegular:18];
        [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:titleButton];
        [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleButtonTop);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(titleButtonHeight);
        }];
        
        if (idx != self.titleArray.count) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
            [self.titleView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleButton.mas_bottom).offset(0);
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(0.5);
            }];
        }
    }];
}

@end
