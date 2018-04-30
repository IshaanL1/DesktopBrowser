//
//  BrowserMenuViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuViewController.h"
#import "NSException+DBR.h"

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak, nullable) WKWebView* webView;
@property (nonatomic, strong, nullable) void (^completion)(UIViewController*);

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(void (^__nullable)(UIViewController*))completion;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithWebView:webView withCompletionHandler:completion];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithWebView:(WKWebView*)webView withCompletionHandler:(void (^__nullable)(UIViewController*))completion;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    [NSException throwIfNilObject:self];
    _webView = webView;
    _completion = completion;
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end
