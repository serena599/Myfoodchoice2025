#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <WKNavigationDelegate, WKScriptMessageHandler>

- (instancetype)initWithURL:(NSURL *)url;

@end