//
//  LRWebViewController.h
//  LRKit
//
//  Created by lirui on 2023/4/4.
//

#import "LRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LRWebViewController : LRBaseViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) BOOL isHiddenProgress;

@end

NS_ASSUME_NONNULL_END
