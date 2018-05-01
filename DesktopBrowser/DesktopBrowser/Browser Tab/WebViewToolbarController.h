//
//  WebViewToolbarController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import WebKit;

@interface WebViewToolbarController : NSObject

@property (nonatomic, weak, readonly) WKWebView* webView;
@property (nonatomic, weak, nullable) UINavigationItem* navigationItem;
@property (nonatomic, weak, nullable) UIBarButtonItem* backButton;
@property (nonatomic, weak, nullable) UIBarButtonItem* forwardButton;

- (instancetype)initWithManagedWebView:(WKWebView*)webView;

@end
