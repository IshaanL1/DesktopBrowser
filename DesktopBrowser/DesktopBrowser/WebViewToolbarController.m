//
//  WebViewToolbarController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "WebViewToolbarController.h"
#import "NSException+DBR.h"

@interface WebViewToolbarController ()


@end

@implementation WebViewToolbarController

static void * XXContext = &XXContext;
static NSString* kCanGoBackKeyPath = @"canGoBack";
static NSString* kCanGoForwardKeyPath = @"canGoForward";
static NSString* kPageTitle = @"title";

- (instancetype)initWithManagedWebView:(WKWebView*)webView;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _webView = webView;
    [webView addObserver:self
              forKeyPath:kCanGoBackKeyPath
                 options:0
                 context:XXContext];
    [webView addObserver:self
              forKeyPath:kCanGoForwardKeyPath
                 options:0
                 context:XXContext];
    [webView addObserver:self
              forKeyPath:kPageTitle
                 options:0
                 context:XXContext];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == XXContext && object == [self webView]) {
        if ([keyPath isEqualToString:kCanGoBackKeyPath]) {
            BOOL canGoBack = [[self webView] canGoBack];
            [[self backButton] setEnabled:canGoBack];
        } else if ([keyPath isEqualToString:kCanGoForwardKeyPath]) {
            BOOL canGoForward = [[self webView] canGoForward];
            [[self forwardButton] setEnabled:canGoForward];
        } else if ([keyPath isEqualToString:kPageTitle]) {
            NSString* title = [[self webView] title];
            [[self navigationItem] setTitle:title];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
