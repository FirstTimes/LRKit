//
//  LRCountDownButton.m
//  LRKit
//
//  Created by lirui on 2022/6/2.
//

#import "LRCountDownButton.h"

@interface LRCountDownButton ()

@property (nonatomic, assign) NSInteger totalSeconds;
@property (nonatomic, assign) NSInteger remainSeconds;

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation LRCountDownButton

- (instancetype)init {
    if (self = [super init]) {
      [self showStopStatus];
    }
    return self;
}

- (void)startCountDownForm:(NSInteger)totalSeconds {
    self.totalSeconds = totalSeconds;
    self.startDate = [NSDate date];

    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        weakSelf.remainSeconds = weakSelf.totalSeconds - [[NSDate date] timeIntervalSinceDate:weakSelf.startDate];

        if (weakSelf.remainSeconds <= 0) { // 倒计时结束
            dispatch_source_cancel(_timer);

            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showStopStatus];
            });
        } else { // 倒计时中
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *timeString = [NSString stringWithFormat:@"%.ld", (long)weakSelf.remainSeconds];
                [weakSelf showInCountDownStautsWithTimeString:timeString];
            });
        }
    });

    dispatch_resume(_timer);
}

- (void)stopCountDown {
    self.remainSeconds = 0;
}

#pragma mark - Private Methods

- (void)showStopStatus {
    [self setTitle:self.titleForNormal ?: @"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForNormal ?: [UIColor colorWithHexString:@"3A9CED"] forState:UIControlStateNormal];

    self.userInteractionEnabled = YES;
}

- (void)showInCountDownStautsWithTimeString:(NSString *)timeString {
    NSString *titleForCountDown = [NSString stringWithFormat:@"%@s%@",timeString, self.titleForCountDown ?: @""];
    [self setTitle:titleForCountDown forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForCountDown ?: [UIColor colorWithHexString:@"CCCCCC"] forState:UIControlStateNormal];

    self.userInteractionEnabled = NO;
}

@end
