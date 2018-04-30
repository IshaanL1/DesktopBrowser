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

@property (nonatomic, strong, nullable) void (^completion)(UIViewController*);
@property (nonatomic, strong, nonnull) WKWebView* webView;
@property (nonatomic, strong, nonnull) WebViewScaleController* scaleController;
@property (nonatomic, strong, nonnull) WebViewToolbarController* toolbarController;
@property (nonatomic, strong, nonnull) UIBarButtonItem* backButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* forwardButton;
@property (nonatomic, strong, nonnull) UIBarButtonItem* menuButton;

@end

@implementation BrowserTabViewController

// MARK: INIT

+ (UIViewController*)browserTabWithCompletionHandler:(void (^__nullable)(UIViewController* __nonnull))completion;
{
    BrowserTabViewController* browserVC = [[BrowserTabViewController alloc] initWithCompletionHandler:completion];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:browserVC];
    return navigationVC;
}

- (instancetype)initWithCompletionHandler:(void (^__nullable)(UIViewController* __nonnull))completion;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    WKWebView* webView = [[WKWebView alloc] init_DBR];
    _completion = completion;
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
            [[self scaleController] setBrowserScale:action];
        }
    };
    UIViewController* menuVC = [BrowserMenuViewController browserMenuForWebView:[self webView]
                                                            currentWebViewScale:[[self scaleController] browserScale]
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
