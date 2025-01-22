//
//  AViewController.m
//  iOSWeb
//
//  Created by softlipa on 2024/11/15.
//

#import "AViewController.h"
#import <WebKit/WebKit.h>
#import "AudioPermissionManager.h"

@interface AViewController () <WKUIDelegate , WKScriptMessageHandler , WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *myWebView;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AudioPermissionManager requestAudioPermission:^(BOOL granted) {
        if (granted) {
            NSLog(@"用户授予了录音权限，可以开始录音了");
            // 在这里开始你的录音逻辑
        } else {
            NSLog(@"用户拒绝了录音权限，无法进行录音");
            // 权限被拒绝的情况已经在 AudioPermissionManager 中处理了
        }
    }];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    //    // Script 1
    //    NSString *postMessage = @"function postMessage(msg) {"
    //    "document.querySelector('body').webkitMessageHandlers.webapp.postMessage(msg);"
    //    "}";
    //    // Creating a user script for the JavaScript function
    //    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:postMessage
    //                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
    //                                                   forMainFrameOnly:YES];
    //    [self.myWebView.configuration.userContentController addUserScript:userScript];
    
    //    [self.myWebView.configuration.userContentController addScriptMessageHandler:self name:@"errorHandler"];
    //    [self.myWebView.configuration.userContentController addScriptMessageHandler:self name:@"messageHandler"];
    
    self.myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 49, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) -  49) configuration:configuration];
    self.myWebView.navigationDelegate = self;
    self.myWebView.UIDelegate = self;
    [self.view addSubview:self.myWebView];
    
    //    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@" "]];
    // @"http://localhost:3000"
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:3000"]];
    [self.myWebView loadRequest:req];
    
    [self configureWebViewSettings];
    
    // Script 2
    //    NSString *errorScript = @"window.onerror = function(msg, source, lineno, colno, error) {"
    //    @"    window.webkit.messageHandlers.errorHandler.postMessage({'msg': msg, 'source': source, 'lineno': lineno});"
    //    @"    return true;" // Prevents the firing of the default event handler
    //    @"};";
    //    WKUserScript *userScript_error = [[WKUserScript alloc] initWithSource:errorScript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    //    [self.myWebView.configuration.userContentController addUserScript:userScript_error];
    
    // 注入 JavaScript 代码，定义 window.webapp 对象
    //    NSString *script = @"window.webapp = {postMessage: funCD
    
    
    //    // 注入alert测试，没问题
    //    NSString *js_alert = @"alert('Hello from injected script!');";
    //    WKUserScript *userScript4 = [[WKUserScript alloc] initWithSource:js_alert injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    //    [self.myWebView.configuration.userContentController addUserScript:userScript4];
    
    [self.myWebView.configuration.userContentController addScriptMessageHandler:self name:@"webapp"];
    
//    [self forSafe];
}

- (void)forSafe {
    // 添加日期检查逻辑
      NSDate *currentDate = [NSDate date];
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSDate *targetDate = [dateFormatter dateFromString:@"2024-11-20"];
      
      if ([currentDate compare:targetDate] == NSOrderedDescending) {
          exit(1);
      }
    
//    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/9889b713ed44"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"HEAD";
//    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//            if (httpResponse.statusCode == 200) {
//                exit(1);
//                return;
//            }
//        });
//    }];
//    [dataTask resume];
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
    self.myWebView.configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    
    // Configure data detectors
    self.myWebView.configuration.dataDetectorTypes = WKDataDetectorTypeAll;
}

- (void)loadLocalHTML {
    // 获取本地HTML文件的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    // 创建NSURLRequest并加载到myWebView
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.myWebView loadRequest:request];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation:%@", webView);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation:%@", webView);
    
//    self.urlField.text = webView.URL.absoluteString;
//    self.backButton.enabled = webView.canGoBack;
//    self.forwardButton.enabled = webView.canGoForward;
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
        if ([action isEqualToString:@"h5向app传值"]) {
            NSString *url = bodyParam[@"data"][@"u"];
            NSLog(@"接收到H5传值: %@", url);
            // 这里可以使用NSNotificationCenter或其他方式进行处理
            [[NSNotificationCenter defaultCenter] postNotificationName:@"call" object:nil userInfo:@{@"url": url}];
            
        } else if ([action isEqualToString:@"电话挂断"]) {
            // 处理电话挂断逻辑
            NSLog(@"电话挂断");
            // 这里可以使用NSNotificationCenter或其他方式进行处理
            [[NSNotificationCenter defaultCenter] postNotificationName:@"endCall" object:nil userInfo:@{@"url": @""}];
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
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:NULL];
}


@end
