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

@interface BrowserTabViewController () <UIBarButtonItemBackAndForwardable>

@property (nonatomic, strong, nonnull) BrowserTabConfiguration* configuration;
@property (nonatomic, strong, nonnull) WKWebView* webView;
@property (nonatomic, strong, nonnull) WebViewScaleController* scaleController;
@property (nonatomic, strong, nonnull) WebViewToolbarController* toolbarController;
@property (nonatomic, strong, nonnull) UIBarButtonItem* backButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* forwardButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* menuButton;
@property (nonatomic, strong, nonnull) BrowserTabViewControllerCompletionHandler completion;

@end

@implementation BrowserTabViewController

// MARK: INIT

+ (UIViewController*)browserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                               completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
{
    BrowserTabViewController* browserVC = [[BrowserTabViewController alloc] initWithConfiguration:configuration completionHandler:completionHandler];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:browserVC];
    return navigationVC;
}

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                    completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    WKWebView* webView = [[WKWebView alloc] init_DBR];
    _configuration = configuration;
    _completion = completionHandler;
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
    [self loadURLString:[config currentURLString]];
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
    __weak BrowserTabViewController *welf = self;
    void (^action)(UIViewController* __nonnull, BrowserMenuAction* __nullable) = ^(UIViewController* vc, BrowserMenuAction* _action) {
        if (!_action) {
            // if action is nil, don't do anything, just dismiss
            [vc dismissViewControllerAnimated:YES completion:nil];
        } else if ([_action isKindOfClass:[BrowserMenuActionURLChange class]]) {
            // if its a URLChange action we need to load the page and dismiss the vc
            BrowserMenuActionURLChange* action = (BrowserMenuActionURLChange*)_action;
            [welf loadURLString:[action urlString]];
            [vc dismissViewControllerAnimated:YES completion:nil];
        } else if ([_action isKindOfClass:[BrowserMenuActionScaleChange class]]) {
            // if its a scale change action we need to change the scale, but not dismiss the vc
            BrowserMenuActionScaleChange* action = (BrowserMenuActionScaleChange*)_action;
            [[self scaleController] setBrowserScale:[action scale]];
        } else if ([_action isKindOfClass:[BrowserMenuActionBoolChange class]]) {
            // if JS changes, update the webview and refresh the page
            BrowserMenuActionBoolChange* action = (BrowserMenuActionBoolChange*)_action;
            [[[[self webView] configuration] preferences] setJavaScriptEnabled:[action boolValue]];
            [[self webView] reload];
        } else if ([_action isKindOfClass:[BrowserMenuActionCloseTab class]] || [_action isKindOfClass:[BrowserMenuActionHideTab class]]) {
            // pass on hide and close actions to our completion handler
            BrowserTabViewControllerCompletionHandler block = [self completion];
            if (!block) { return; }
            [vc dismissViewControllerAnimated:YES completion:^{
                block(welf, [self configuration], _action);
            }];
        }
    };
    UIViewController* menuVC = [BrowserMenuViewController browserMenuWithConfiguration:[self configuration]
                                                               presentingBarButtonItem:sender
                                                                 withCompletionHandler:action];
    [self presentViewController:menuVC animated:YES completion:nil];
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
