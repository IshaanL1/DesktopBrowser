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
#import "UIBarButtonItem+DBR.h"
#import "BrowserMenuViewController.h"

@interface BrowserTabViewController () <UIBarButtonItemBackAndForwardable, BrowserMenuViewControllerDelegate>

@property (nonatomic, strong, nonnull) BrowserTabConfiguration* configuration;
@property (nonatomic, strong, nonnull) WKWebView* webView;
@property (nonatomic, strong, nonnull) WebViewScaleController* scaleController;
@property (nonatomic, strong, nonnull) WebViewToolbarController* toolbarController;
@property (nonatomic, strong, nonnull) UIBarButtonItem* backButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* forwardButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* menuButton;
@property (nonatomic, strong, nonnull) BrowserTabViewControllerCompletionHandler completion;
@property (nonatomic, weak, nullable) id<BrowserTabConfigurationChangeDelegate> configurationChangeDelegate;

@end

@implementation BrowserTabViewController

// MARK: INIT

+ (UIViewController*)browserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                     configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                               completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
{
    BrowserTabViewController* browserVC = [[BrowserTabViewController alloc] initWithConfiguration:configuration
                                                                      configurationChangeDelegate:delegate
                                                                                completionHandler:completionHandler];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:browserVC];
    return navigationVC;
}

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
          configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                    completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    WKWebView* webView = [[WKWebView alloc] init_DBR];
    _configuration = configuration;
    _completion = completionHandler;
    _configurationChangeDelegate = delegate;
    _scaleController = [[WebViewScaleController alloc] initWithManagedWebView: webView];
    _toolbarController = [[WebViewToolbarController alloc] initWithManagedWebView:webView];
    _webView = webView;
    _backButton = [UIBarButtonItem newDisabledBackButtonItemWithTarget:self];
    _forwardButton = [UIBarButtonItem newDisabledForwardButtonItemWithTarget:self];
    _menuButton = [UIBarButtonItem newMenuButtonItemWithTarget:self];
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];

    // configure toolbar items
    [[self navigationItem] setRightBarButtonItems:@[[self menuButton]]];
    [[self navigationItem] setLeftBarButtonItems:@[[self backButton], [self forwardButton]]];
    [[self toolbarController] setBackButton:[self backButton]];
    [[self toolbarController] setForwardButton:[self forwardButton]];
    [[self toolbarController] setNavigationItem:[self navigationItem]];

    // configure the webview constraints
    [[self view] addSubview:[self webView]];
    [[self view] addConstraints:@[
                                  [[[self view] centerXAnchor] constraintEqualToAnchor:[[self webView] centerXAnchor]],
                                  [[[self view] centerYAnchor] constraintEqualToAnchor:[[self webView] centerYAnchor]],
                                  ]];
    [[self scaleController] viewDidLoad];

    // configure the webview with the configuration
    BrowserTabConfiguration* config = [self configuration];
    [NSException throwIfNilObject:config];
    [[self scaleController] setBrowserScale:[config scale]];
    [[[[self webView] configuration] preferences] setJavaScriptEnabled:[config javascriptEnabled]];
    [self loadURLString:[config urlString]];
}

// MARK: UIBarButtonItemBackAndForwardable

- (IBAction)backButtonTapped:(id)sender;
{
    [[self webView] goBack];
}

- (IBAction)forwardButtonTapped:(id)sender;
{
    [[self webView] goForward];
}

- (IBAction)menuButtonTapped:(id)sender;
{
    UIViewController* menuVC = [BrowserMenuViewController browserMenuWithConfiguration:[self configuration]
                                                                              delegate:self
                                                               presentingBarButtonItem:sender];
    [self presentViewController:menuVC animated:YES completion:nil];
}

// MARK: BrowserMenuTableViewControllerDelegate

- (void)userDidChangeURLString:(NSString* __nonnull)newURLString fromViewController:(UIViewController*)vc;
{
    [self loadURLString:newURLString];
    [vc dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidChangeWebViewScale:(double)newScale fromViewController:(UIViewController*)vc;
{
    [[self scaleController] setBrowserScale:newScale];
}
- (void)userDidChangeJSEnabled:(BOOL)newJSEnabled fromViewController:(UIViewController*)vc;
{
    [[[[self webView] configuration] preferences] setJavaScriptEnabled:newJSEnabled];
    [[self webView] reload];
}
- (void)userDidSelectHideTabFromViewController:(UIViewController*)vc;
{
    BrowserTabViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    [vc dismissViewControllerAnimated:YES completion:^{
        block(self, [self configuration], NO);
    }];
}
- (void)userDidSelectCloseTabFromViewController:(UIViewController*)vc;
{
    BrowserTabViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    [vc dismissViewControllerAnimated:YES completion:^{
        block(self, [self configuration], YES);
    }];
}
- (void)userDidRequestCloseMenuFromViewController:(UIViewController*)vc;
{
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadURLString:(NSString*)urlString;
{
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:urlString]];
    [[self webView] loadRequest:request];
}

// MARK: Handle Screen Changing Size

- (void)viewSafeAreaInsetsDidChange;
{
    [super viewSafeAreaInsetsDidChange];
    [[self scaleController] updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:[[self view] safeAreaInsets]];
}

@end
