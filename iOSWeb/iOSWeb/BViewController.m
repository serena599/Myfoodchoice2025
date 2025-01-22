//
//  BViewController.m
//  iOSWeb
//
//  Created by softlipa on 2024/11/15.
//

#import "BViewController.h"
#import <WebKit/WebKit.h>
#import "AudioPermissionManager.h"

@interface BViewController () <WKUIDelegate , WKScriptMessageHandler , WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *myWebView;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];

    self.myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 49, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) -  49) configuration:configuration];
    self.myWebView.backgroundColor = [UIColor whiteColor];
    self.myWebView.scrollView.backgroundColor = [UIColor whiteColor];
    self.myWebView.navigationDelegate = self;
    self.myWebView.UIDelegate = self;
    [self.view addSubview:self.myWebView];

    [self configureWebViewSettings];
    
    [self.myWebView.configuration.userContentController addScriptMessageHandler:self name:@"webapp"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleCallNotification:)
                                                     name:@"call"
                                                   object:nil];
    }
    return self;
}

// 处理"call"通知
- (void)handleCallNotification:(NSNotification *)notifi {
    NSLog(@"BViewController.handleCallNotification: %@", notifi);
    
    NSString *urlString = notifi.userInfo[@"url"];
    
    if (urlString) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        
        // 在主线程中加载请求
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myWebView loadRequest:req];
        });
    } else {
        NSLog(@"BViewController未找到 URL");
    }
}

- (void)configureWebViewSettings {
    self.myWebView.configuration.preferences.javaScriptEnabled = YES;
    self.myWebView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    if (@available(iOS 14.0, *)) {
        self.myWebView.configuration.defaultWebpagePreferences.allowsContentJavaScript = YES;
    }
    
    self.myWebView.allowsBackForwardNavigationGestures = YES;
    [self.myWebView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    self.myWebView.configuration.preferences.minimumFontSize = 12;
    self.myWebView.configuration.allowsInlineMediaPlayback = YES;
    self.myWebView.configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
    
    // Configure data detectors
    self.myWebView.configuration.dataDetectorTypes = WKDataDetectorTypeAll;
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation:%@", webView);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation:%@", webView);
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation:%@", webView);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"MessageHandler:%@", message);
    NSLog(@"MessageHandler userContentController:%@", userContentController);
    
    NSLog(@"MessageHandler Name:%@", message.name);
    NSLog(@"MessageHandler Body:%@", message.body);
    
    if ([message.name isEqualToString:@"webapp"]) {
        id body = message.body;
        NSDictionary *bodyParam;
        
        // 判断 message.body 的类型
        if ([body isKindOfClass:[NSDictionary class]]) {
            bodyParam = (NSDictionary *)body;
        } else if ([body isKindOfClass:[NSString class]]) {
            NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            bodyParam = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                NSLog(@"JSON解析错误: %@", error);
                return;
            }
        }
        
        NSString *action = bodyParam[@"data"][@"action"];
        if ([action isEqualToString:@"电话挂断"]) {
            // 处理电话挂断逻辑
            NSLog(@"电话挂断");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reset" object:nil userInfo:nil];
        }
    }
}


#pragma mark - WKUIDelegate

- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
//uiwebview 中这个方法是私有方法 通过category可以拦截alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

    NSLog(@"%s", __FUNCTION__);
    
    completionHandler();
}


@end
