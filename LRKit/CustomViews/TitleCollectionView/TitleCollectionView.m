//
//  TitleCollectionView.m
//  LRKit
//
//  Created by lirui on 2021/8/29.
//

#import "TitleCollectionView.h"
#import "TitleCollectionCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "NSString+Utility.h"
#import <Masonry.h>

@interface TitleCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation TitleCollectionView

- (instancetype)initWithTitleArray:(NSArray <NSString *> *)titleArray {
    self = [super init];
    if (self) {
        self.titleArray = titleArray;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        [self configureViews];
    }
    return self;
}

#pragma mark - Private Methods

- (void)configureViews {
    UICollectionViewLeftAlignedLayout * collectionViewLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    collectionViewLayout.minimumLineSpacing = self.minimumLineSpacing;
    collectionViewLayout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:@"TitleCollectionCell"];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressAction:)];
    [self.collectionView addGestureRecognizer:longPress];
}

- (void)lonePressAction:(UILongPressGestureRecognizer *)longPress {
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
    switch (longPress.state) {
        // 开始
        case UIGestureRecognizerStateBegan: {
            if (selectIndexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
            
        // 移动中
        case UIGestureRecognizerStateChanged: {
            if (selectIndexPath.item < self.titleArray.count) {
                [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:longPress.view]];
            } else {
                [self.collectionView cancelInteractiveMovement];
            }
            break;
        }
            
        // 结束
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            break;
        }
            
        default: {
            [self.collectionView cancelInteractiveMovement];
            break;
                    
        }
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionCell" forIndexPath:indexPath];
    cell.contentBackgroundColor = [UIColor whiteColor];
    
    NSString *title = self.titleArray[indexPath.row];
    [cell updateWithTitle:title];
    [cell updateWithTitleColor:self.titleColor titleFont:self.titleFont];
    [cell updateWithTitleEdgeInsets:self.titleEdgeInsets];
    [cell addCornerWithRadius:self.cellCornerRadius];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titleArray[indexPath.row];
    CGFloat titleWidth = [title textWidthWithFont:self.titleFont height:self.titleHeight];
    CGFloat cellWidth = self.titleEdgeInsets.left + self.titleEdgeInsets.right + titleWidth;
    CGFloat cellHeight = self.titleEdgeInsets.top + self.titleEdgeInsets.bottom + self.titleHeight;
    return CGSizeMake(cellWidth, cellHeight);
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.titleArray.count) {
        return YES;
    }else {
        return NO;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    NSString *title = [self.titleArray objectAtIndex:sourceIndexPath.item];
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray:self.titleArray];
    [titleArray removeObjectAtIndex:sourceIndexPath.item];
    [titleArray insertObject:title atIndex:destinationIndexPath.item];
    self.titleArray = [NSArray arrayWithArray:titleArray];
    [self.collectionView reloadData];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    if (self.collectionView) {
        self.collectionView.contentInset = contentInset;
    }
}

@end
