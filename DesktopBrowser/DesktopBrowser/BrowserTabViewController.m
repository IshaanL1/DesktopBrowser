//
//  BrowserTabViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserTabViewController.h"
#import "NSException+DBR.h"
#import "WKWebView+DBR.h"
#import "WebViewScaleController.h"
#import "WebViewToolbarController.h"

@interface BrowserTabViewController ()

@property (nonatomic, strong, nullable) void (^completion)(UIViewController*);
@property (nonatomic, strong, nonnull) WKWebView* webView;
@property (nonatomic, strong, nonnull) WebViewScaleController* scaleController;
@property (nonatomic, strong, nonnull) WebViewToolbarController* toolbarController;
@property (nonatomic, strong, nonnull) UIBarButtonItem* backButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* forwardButton;

@end

@implementation BrowserTabViewController

+ (UIViewController*)browserTabWithCompletionHandler:(void (^__nullable)(UIViewController*))completion;
{
    BrowserTabViewController* browserVC = [[BrowserTabViewController alloc] initWithCompletionHandler:completion];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:browserVC];
    return navigationVC;
}

- (instancetype)initWithCompletionHandler:(void (^__nullable)(UIViewController*))completion;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    WKWebView* webView = [[WKWebView alloc] init_DBR];
    _completion = completion;
    _scaleController = [[WebViewScaleController alloc] initWithManagedWebView: webView];
    _toolbarController = [[WebViewToolbarController alloc] initWithManagedWebView:webView];
    _webView = webView;
    return self;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];

    // configure toolbar items
    [[self toolbarController] setNavigationItem:[self navigationItem]];

    // configure the webview constraints
    [[self view] addSubview:[self webView]];
    [[self view] addConstraints:@[
                                  [[[self view] centerXAnchor] constraintEqualToAnchor:[[self webView] centerXAnchor]],
                                  [[[self view] centerYAnchor] constraintEqualToAnchor:[[self webView] centerYAnchor]],
                                  ]];

    // fake stuff to make it work while building the app
    [[self scaleController] setBrowserScale:3];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://theverge.com"]];
    [[self webView] loadRequest:request];
}

- (void)viewSafeAreaInsetsDidChange;
{
    [super viewSafeAreaInsetsDidChange];
    [[self scaleController] updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:[[self view] safeAreaInsets]];
}

@end
