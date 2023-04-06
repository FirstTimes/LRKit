//
//  LRWeakScriptMessageDelegate.m
//  LRKit
//
//  Created by lirui on 2023/4/4.
//

#import "LRWeakScriptMessageDelegate.h"

@implementation LRWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

- (void)dealloc {
    
}

@end
