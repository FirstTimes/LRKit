//
//  TestViewController.m
//  LRKit
//
//  Created by lirui on 2022/1/10.
//

#import "TestViewController.h"
#import "NSDecimalNumber+Utility.h"
#import "LRAlignmentLabel.h"
#import "LRMarginLabel.h"
#import "LRDeviceHelper.h"
#import "UITextField+Utility.h"
#import "NSString+Utility.h"
#import "LRChoosePhotoHelper.h"
#import "LRChoosePhotoView.h"
#import "UIImage+Utility.h"

@interface TestViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    self.navigationItem.title = @"测试";
    
//    LRAlignmentLabel *alignmentLabel = [[LRAlignmentLabel alloc] init];
//    alignmentLabel.text = @"菲菲姐副机位副机位IT我无附件为if降温if副机位副机位if我机服务费今晚if交付物if降温我瑞几覅全家福你无法叫我覅违反";
//    alignmentLabel.backgroundColor = [UIColor purpleColor];
//    alignmentLabel.numberOfLines = 0;
//    alignmentLabel.verticalAlignment = LRVerticalAlignmentBottom;
//    [self.view addSubview:alignmentLabel];
//    [alignmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(300);
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//        make.height.mas_equalTo(180);
//    }];
//
//    LRMarginLabel *marginLabel = [[LRMarginLabel alloc] init];
//    marginLabel.text = @"菲菲姐副机位副机位我无附件为降温副机位副机位我机服务费今晚交付物降温我瑞几覅全家福你无法叫我覅违反";
//    marginLabel.backgroundColor = [UIColor greenColor];
//    marginLabel.numberOfLines = 0;
//    marginLabel.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    [self.view addSubview:marginLabel];
//    [marginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(500);
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//        make.height.mas_equalTo(100);
//    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage backBlackImage];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(180);
    }];
    self.imageView = imageView;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.delegate = self;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(30);
    }];
    
    NSDecimalNumber * a = [NSDecimalNumber decimalNumberWithString:@"0.0005"];
    NSDecimalNumber *sum = [a multiplyByPowerOf10:3];
    NSLog(@"sum = %@", sum.stringValue);
    
    NSLog(@"device systemName:%@, systemVersion:%@, machineModel:%@, machineModelName:%@", [LRDeviceHelper systemName], [LRDeviceHelper systemVersionName], [LRDeviceHelper machineModel], [LRDeviceHelper machineModelName]);
    
    NSArray *dict = @[@"name", @"lirui", @"age"];
    NSString *jsonStrinng = [NSString jsonStringWithArray:dict];
    NSLog(@"jsonStrinng : %@", jsonStrinng);
    
    NSString *whitespace = @"  jfwiwfji  ifjif\n费积分几位  ";
    NSLog(@"whitespace :%@", [whitespace removeAllWhitespaceAndAllLineBreaks]);
    
    if ([self.title isEqualToString:@"A"]) {
        self.view.backgroundColor = [UIColor redColor];
    } else if ([self.title isEqualToString:@"B"]) {
        self.view.backgroundColor = [UIColor blueColor];
    } else if ([self.title isEqualToString:@"C"]) {
        self.view.backgroundColor = [UIColor yellowColor];
    }
    
    UIButton *pushButton1 = [[UIButton alloc] init];
    [pushButton1 setBackgroundColor:[UIColor redColor]];
    [pushButton1 setTitle:@"测试1" forState:UIControlStateNormal];
    [self.view addSubview:pushButton1];
    [pushButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [pushButton1 addTarget:self action:@selector(pushToA) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pushButton2 = [[UIButton alloc] init];
    [pushButton2 setBackgroundColor:[UIColor blueColor]];
    [pushButton2 setTitle:@"测试2" forState:UIControlStateNormal];
    [self.view addSubview:pushButton2];
    [pushButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pushButton1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [pushButton2 addTarget:self action:@selector(pushToB) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pushButton3 = [[UIButton alloc] init];
    [pushButton3 setBackgroundColor:[UIColor yellowColor]];
    [pushButton3 setTitle:@"测试2" forState:UIControlStateNormal];
    [self.view addSubview:pushButton3];
    [pushButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pushButton2.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [pushButton3 addTarget:self action:@selector(pushToC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushToA {
//    TestViewController *testA = [TestViewController new];
//    testA.title = @"A";
//    [self.navigationController pushViewController:testA animated:YES];
    NSArray *titleArray = @[@"拍照", @"从手机相册选择"];
    LRChoosePhotoView *choosePhotoView = [[LRChoosePhotoView alloc] initWithTitleArray:titleArray];
    [choosePhotoView show];
    __weak typeof (LRChoosePhotoView) *weakChoosePhotoView = choosePhotoView;
    choosePhotoView.choosePhotoBlock = ^(LRChoosePhotoWayType choosePhotoWayType) {
        switch (choosePhotoWayType) {
            case LRChoosePhotoWayTypeCamera:{
                [LRChoosePhotoHelper chooseFromCameraOnViewController:self allowEdit:NO completion:^(UIImage * _Nonnull image) {
                    NSLog(@"%@",image);
                }];
                [weakChoosePhotoView dismiss];
            }
                break;
                
            case LRChoosePhotoWayTypeAlbum: {
                [LRChoosePhotoHelper chooseFromAlbumOnViewController:self maxCount:1 completion:^(NSArray<UIImage *> * _Nonnull images) {
                    UIImage *image = [images firstObject];
                    UIImage *rotationImage = [image rotationImage:image withOrientation:UIImageOrientationRight];
                    self.imageView.image = rotationImage;
                    NSLog(@"%@",images);
                }];
                [weakChoosePhotoView dismiss];
            }
                break;
        }
    };
    
}

- (void)pushToB {
    TestViewController *testB = [TestViewController new];
    testB.title = @"B";
    [self.navigationController pushViewController:testB animated:YES];
}

- (void)pushToC {
    TestViewController *testC = [TestViewController new];
    testC.title = @"C";
    [self.navigationController pushViewController:testC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [UITextField textFieldKeepTwoDecimalPlacesWithShouldChangeCharactersInRange:range string:string textField:textField];
}

@end
