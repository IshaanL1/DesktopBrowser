//
//  WebViewScaleController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import WebKit;

typedef BOOL(^DoubleInDoubleOutBlock)(double scale);

@interface WebViewScaleController : NSObject

@property (class, nonatomic, strong, readonly, nonnull) DoubleInDoubleOutBlock verifyScale;
@property (nonatomic, weak, readonly) WKWebView* webView;
@property (nonatomic) double browserScale;

- (instancetype)initWithManagedWebView:(WKWebView*)webView;
- (void)updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:(UIEdgeInsets) safeAreaInsets;
- (void)viewDidLoad;

@end
