//
//  LRPickerSelectView.m
//  LRKit
//
//  Created by lirui on 2023/4/7.
//

#import "LRPickerSelectView.h"

@interface LRPickerSelectView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *selectedText;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LRPickerSelectView

#pragma mark - Public Methods

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray <NSString *> *)dataArray {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.title = title;
    self.dataArray = [NSArray arrayWithArray:dataArray];
    [self initProperties];
    [self configureViews];
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)selectAtIndex:(NSUInteger)index {
    if (index < self.dataArray.count) {
        self.index = index;
        self.selectedText = self.dataArray[self.index];
        [self.pickerView selectRow:self.index inComponent:0 animated:NO];
    } else {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
}

#pragma mark - Action Methods

- (void)confirm {
    if (self.confirmButtonClickedBlock) {
        self.confirmButtonClickedBlock(self.index, self.selectedText);
    }
    [self dismiss];
}

#pragma mark - Private Methods

- (void)initProperties {
    self.index = 0;
    self.selectedText = self.dataArray[self.index];
}

- (void)configureViews {
    [self configureSelf];
    [self configureContentView];
    [self configureTitleLabel];
    [self configurePickerView];
    [self configureButtons];
}

- (void)configureSelf {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
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
        make.height.mas_equalTo(248);
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

- (void)configurePickerView {
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.contentView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(160);
    }];
}

- (void)configureButtons {
    UIView *horizontallyLine = [[UIView alloc] init];
    horizontallyLine.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
    [self.contentView addSubview:horizontallyLine];
    [horizontallyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pickerView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorWithHexString:@"CCCCCC"] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont pingFangRegular:16];
    [self.contentView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(44);
    }];
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
    [self.contentView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(self.cancelButton.mas_right).offset(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    
    self.confirmButton = [[UIButton alloc] init];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor colorWithHexString:@"FC4260"] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont pingFangMedium:16];
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontallyLine.mas_bottom).offset(0);
        make.left.mas_equalTo(verticalLine.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.text = self.dataArray[row];
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (@available(iOS 14.0, *)) {
        pickerView.subviews[1].backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.12];
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.index = row;
    self.selectedText = self.dataArray[self.index];
    [pickerView reloadAllComponents];
}

@end
