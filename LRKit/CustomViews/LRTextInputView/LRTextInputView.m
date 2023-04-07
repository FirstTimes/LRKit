//
//  LRTextInputView.m
//  LRKit
//
//  Created by lirui on 2023/4/7.
//

#import "LRTextInputView.h"

@interface LRTextInputView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *wordSumLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) NSUInteger wordSum;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation LRTextInputView

#pragma mark - Public Methods

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.wordSum = 100;
        self.leftButtonTitle = @"取消";
        self.rightButtonTitle = @"确认";
        self.viewHeight = 297.f;
        [self initProperties];
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title wordSum:(NSUInteger)wordSum leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle viewHeight:(CGFloat)viewHeight {
    self = [super init];
    self.title = title;
    self.wordSum = wordSum;
    self.leftButtonTitle = leftButtonTitle;
    self.rightButtonTitle = rightButtonTitle;
    self.viewHeight = viewHeight;
    [self initProperties];
    [self configureViews];
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)updateTextViewPlaceholder:(NSString *)placeholder {
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.hidden = placeholder.length == 0;
}

- (void)updateTextViewWordSum:(NSUInteger)wordSum {
    self.wordSum = wordSum;
    self.wordSumLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.text.length, self.wordSum];
}

- (void)updateTextViewText:(NSString *)text {
    self.placeholderLabel.hidden = YES;
    self.textView.text = text;
    self.text = text;
    self.wordSumLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.textView.text.length, self.wordSum];
}

#pragma mark - Action Methods

- (void)confirm {
    if (self.confirmButtonClickedBlock) {
        self.confirmButtonClickedBlock(self.text);
    }
    if (self.text.length > 0) {
        [self dismiss];
    }
}

#pragma mark - Private Methods

- (void)initProperties {
    self.text = @"";
}

- (void)configureViews {
    [self configureSelf];
    [self configureContentView];
    [self configureTitleLabel];
    [self configureBottomView];
    [self configureTextView];
}

- (void)configureSelf {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}

- (void)configureContentView {
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 16;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(self.viewHeight);
    }];
}

- (void)configureTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont pingFangMedium:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)configureBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIView *horizontallyLine = [[UIView alloc] init];
    horizontallyLine.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
    [self.bottomView addSubview:horizontallyLine];
    [horizontallyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorWithHexString:@"CCCCCC"] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont pingFangRegular:16];
    [self.bottomView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(44);
    }];
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
    [self.bottomView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(self.cancelButton.mas_right).offset(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    
    self.confirmButton = [[UIButton alloc] init];
    [self.confirmButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor colorWithHexString:@"FC4260"] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont pingFangMedium:16];
    [self.bottomView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(verticalLine.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureTextView {
    self.middleView = [[UIView alloc] init];
    self.middleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
    }];
    
    UIView *textContentView = [[UIView alloc] init];
    textContentView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    textContentView.layer.cornerRadius = 5;
    textContentView.layer.masksToBounds = YES;
    [self.middleView addSubview:textContentView];
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-20);
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.textColor = [UIColor colorWithHexString:@"333333"];
    self.textView.font = [UIFont pingFangRegular:14];
    self.textView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.delegate = self;
    [textContentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-24);
    }];
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.text = @"";
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"CCCCCC"];
    self.placeholderLabel.font = [UIFont pingFangRegular:14];
    [textContentView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(10);
    }];
    self.placeholderLabel.hidden = YES;
    
    self.wordSumLabel = [[UILabel alloc] init];
    self.wordSumLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.text.length, self.wordSum];
    self.wordSumLabel.textColor = [UIColor colorWithHexString:@"CCCCCC"];
    self.wordSumLabel.font = [UIFont pingFangRegular:12];
    [textContentView addSubview:self.wordSumLabel];
    [self.wordSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-6);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
    self.wordSumLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, self.wordSum];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *string = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (string.length > self.wordSum) {
        textView.text = [string substringToIndex:self.wordSum];
        self.wordSumLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, self.wordSum];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.text = textView.text;
}

@end
