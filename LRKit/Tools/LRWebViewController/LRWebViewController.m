//
//  LRWebViewController.m
//  LRKit
//
//  Created by lirui on 2023/4/4.
//

#import "LRWebViewController.h"
#import "LRWeakScriptMessageDelegate.h"
#import "UIImage+Utility.h"

static NSString *const PROGRESS_KEY_PATH = @"estimatedProgress";
static NSString *const TITLE_KEY_PATH = @"title";

static NSString *const CopyMessageName = @"CopyMessageName";
static NSString *const GoBackMessageName = @"goBackMessageName";

@interface LRWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) NSArray *scriptMessageHandlerNameArray;
@property (nonatomic, strong) UIView *containerView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@end

@implementation LRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureScriptMessageHandlerNameArray];
    [self configureViews];
    [self addObserver];
    [self loadWebRequest];
}

- (void)dealloc {
    [self removeScriptMessageHandler];
    [self removeObserver];
    [self removeWebView];
}

#pragma mark - Action Methods

- (void)backBarButtonItemClicked {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadWebRequest {
  if (self.urlString.length > 0) {
      NSURL *url = [NSURL URLWithString:self.urlString];
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.f];
      [self.webView loadRequest:request];
  } else {
      NSLog(@"链接不存在!!!");
  }
}

#pragma mark - Configure Methods

- (void)configureScriptMessageHandlerNameArray {
    NSMutableArray *scriptMessageHandlerNameArray = [NSMutableArray array];
    [scriptMessageHandlerNameArray addObject:CopyMessageName];
    [scriptMessageHandlerNameArray addObject:GoBackMessageName];
    
    self.scriptMessageHandlerNameArray = [NSArray arrayWithArray:scriptMessageHandlerNameArray];
}

- (void)configureViews {
    self.containerView = [[UIView alloc] init];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.progressTintColor = [UIColor lightGrayColor];
    self.progressView.hidden = self.isHiddenProgress;
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self configureBackBarButtonItem];
    [self configureWebView];
}

- (void)configureBackBarButtonItem {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:[UIImage backBlackImage] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
    self.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem];
    }
}

- (void)configureWebView {
    WKUserContentController *userContentController = [WKUserContentController new];
    LRWeakScriptMessageDelegate *weakScriptMessageDelegate = [[LRWeakScriptMessageDelegate alloc] initWithDelegate:self];
    [userContentController addScriptMessageHandler:weakScriptMessageDelegate name:CopyMessageName];
    
    self.configuration = [WKWebViewConfiguration new];
    self.configuration.preferences = [WKPreferences new];
    self.configuration.processPool = [WKProcessPool new];
    self.configuration.allowsInlineMediaPlayback = YES;
    self.configuration.userContentController = userContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.containerView.bounds configuration:self.configuration];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.containerView addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)removeScriptMessageHandler {
    if (self.scriptMessageHandlerNameArray.count > 0) {
        [self.scriptMessageHandlerNameArray enumerateObjectsUsingBlock:^(NSString *_Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.webView.configuration.userContentController removeScriptMessageHandlerForName:name];
        }];
    }
}

- (void)removeWebView {
    [self.webView stopLoading];
    self.webView = nil;
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
}

#pragma mark - Observer

- (void)addObserver {
    [self.webView addObserver:self forKeyPath:PROGRESS_KEY_PATH options:NSKeyValueObservingOptionNew context:@"LRWebViewController"];
    [self.webView addObserver:self forKeyPath:TITLE_KEY_PATH options:NSKeyValueObservingOptionNew context:@"LRWebViewController"];
}

- (void)removeObserver {
    [self.webView removeObserver:self forKeyPath:PROGRESS_KEY_PATH context:@"LRWebViewController"];
    [self.webView removeObserver:self forKeyPath:TITLE_KEY_PATH context:@"LRWebViewController"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:PROGRESS_KEY_PATH]) {
    if (!self.isHiddenProgress) {
      CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
      if (newprogress == 1.0) {
        [self.progressView setProgress:0.f animated:NO];
        self.progressView.hidden = YES;
      } else {
        [self.progressView setProgress:newprogress animated:YES];
        self.progressView.hidden = NO;
      }
    }
    } else if (object == self.webView && [keyPath isEqualToString:TITLE_KEY_PATH]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        if (title.length == 0) {
            title = self.webView.title;
        }
        
        if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
            self.navigationItem.title = title;
        } else {
            self.parentViewController.navigationItem.title = title;
        }
    }
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController*)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message.name: %@", message.name);
    NSLog(@"message.body: %@", message.body);
    
    if ([message.name isEqualToString:CopyMessageName]) {
        NSString *copyString = [NSString stringWithFormat:@"%@",message.body];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = copyString;
    } else if ([message.name isEqualToString:GoBackMessageName]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
