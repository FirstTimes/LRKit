//
//  LRCountDownButton.h
//  LRKit
//
//  Created by lirui on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRCountDownButton : UIButton

@property (nonatomic, copy) NSString *titleForNormal;
@property (nonatomic, strong) UIColor *titleColorForNormal;
@property (nonatomic, copy) NSString *titleForCountDown;
@property (nonatomic, strong) UIColor *titleColorForCountDown;

- (void)startCountDownForm:(NSInteger)totalSeconds;
- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
