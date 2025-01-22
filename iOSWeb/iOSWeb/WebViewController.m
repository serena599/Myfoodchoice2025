#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation WebViewController

- (instancetype)initWithURL:(NSURL *)url {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self loadWebContent];
}

- (void)setupWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    [contentController addScriptMessageHandler:self name:@"webapp"];
    configuration.userContentController = contentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.webView];
    
    [self configureWebViewSettings];
}

- (void)configureWebViewSettings {
    self.webView.configuration.preferences.javaScriptEnabled = YES;
    self.webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    if (@available(iOS 14.0, *)) {
        self.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = YES;
    }
    
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    self.webView.configuration.preferences.minimumFontSize = 12;
    self.webView.configuration.allowsInlineMediaPlayback = YES;
    self.webView.configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
}

- (void)loadWebContent {
    if (self.url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.webView loadRequest:request];
    }
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSDictionary *bodyParam = (NSDictionary*)message.body;
    NSString *func = [bodyParam objectForKey:@"function"];
    
    NSLog(@"MessageHandler Name:%@", message.name);
    NSLog(@"MessageHandler Body:%@", message.body);
    NSLog(@"MessageHandler Function:%@",func);
    NSLog(@"MessageHandler userContentController:%@",userContentController);
    
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)message.body;
        NSDictionary *data = dict[@"data"];
        NSString *action = data[@"action"];
        
        if ([action.lowercaseString isEqualToString:@"h5向app传值"]) {
            NSString *u = data[@"u"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"call" object:nil userInfo:@{@"url": u}];
        } else if ([action.lowercaseString isEqualToString:@"电话挂断"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"endCall" object:nil];
        }
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // Handle navigation policy here
    decisionHandler(WKNavigationActionPolicyAllow);
}

// Additional WKNavigationDelegate methods can be implemented here

@end
