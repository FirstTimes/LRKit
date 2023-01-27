//
//  TitleCollectionViewController.m
//  LRKit
//
//  Created by lirui on 2022/1/6.
//

#import "TitleCollectionViewController.h"
#import "TitleCollectionView.h"
#import "UINavigationController+Utility.h"

@interface TitleCollectionViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TitleCollectionView *titleCollectionView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation TitleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self configureViews];
    
    BOOL ishas = [self.navigationController containsViewControllerOfClass:[self class]];
    if (ishas) {
        NSLog(@"包含");
    } else {
        NSLog(@"不包含");
    }
}

#pragma mark - configure

- (void)initProperties {
    self.titleArray = @[@"你好", @"你从哪里来呀", @"你要到哪里去", @"你吃过了吗", @"你住在什么地方啊", @"中午有空吗", @"加个微信呗"];
}

- (void)configureViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTitle];
    [self configTitleCollectionView];
}

- (void)configureTitle {
    self.navigationItem.title = @"TitleCollectionView";
}

- (void)configTitleCollectionView {
    self.titleCollectionView = [[TitleCollectionView alloc] initWithTitleArray:self.titleArray];
    self.titleCollectionView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    self.titleCollectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.titleCollectionView.titleFont = [UIFont pingFangRegular:14];
    self. titleCollectionView.titleColor = [UIColor colorWithHexString:@"333333"];
    self.titleCollectionView.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.titleCollectionView.titleHeight = 20;
    self.titleCollectionView.cellCornerRadius = 10;
    [self.view addSubview:self.titleCollectionView];
    [self.titleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

@end
