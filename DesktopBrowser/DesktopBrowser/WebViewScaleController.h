//
//  WebViewScaleController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import WebKit;

@interface WebViewScaleController : NSObject

@property (nonatomic, weak, readonly) WKWebView* webView;
@property (nonatomic) CGFloat browserScale;

- (instancetype)initWithManagedWebView:(WKWebView*)webView;
- (void)updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:(UIEdgeInsets) safeAreaInsets;

@end
