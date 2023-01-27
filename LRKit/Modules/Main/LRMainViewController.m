//
//  LRMainViewController.m
//  LRKit
//
//  Created by lirui on 2021/7/22.
//

#import "LRMainViewController.h"
#import "TitleCollectionViewController.h"
#import "TestViewController.h"

@interface LRMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *exampleArray;

@end

@implementation LRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self configureViews];
}

#pragma mark - configure

- (void)initProperties {
    self.exampleArray = @[@{@"type":@"TitleCollectionView"},
                          @{@"type":@"Test"}];
}

- (void)configureViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTitle];
    [self configureTableView];
}

- (void)configureTitle {
    self.navigationItem.title = @"LRKit";
}

- (void)configureTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"exampleCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"exampleCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = self.exampleArray[indexPath.row];
    NSString *type = dict[@"type"];
    
    if (@available(iOS 14.0, *)) {
        UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
        contentConfiguration.textProperties.font = [UIFont pingFangRegular:16];
        contentConfiguration.textProperties.color = [UIColor colorWithHexString:@"333333"];
        contentConfiguration.text = type;
        cell.contentConfiguration = contentConfiguration;
    } else {
        cell.textLabel.text = type;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.textLabel.font = [UIFont pingFangRegular:16];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.exampleArray[indexPath.row];
    NSString *type = dict[@"type"];
    if ([type isEqualToString:@"TitleCollectionView"]) {
        TitleCollectionViewController *titleCollectionView = [[TitleCollectionViewController alloc] init];
        [self.navigationController pushViewController:titleCollectionView animated:YES];
    } else if ([type isEqualToString:@"Test"]) {
        TestViewController *testViewController = [[TestViewController alloc] init];
        [self.navigationController pushViewController:testViewController animated:YES];
    }
}

@end
