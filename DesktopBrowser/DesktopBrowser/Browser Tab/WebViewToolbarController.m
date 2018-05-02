//
//  WebViewToolbarController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "WebViewToolbarController.h"
#import "NSException+DBR.h"

@implementation WebViewToolbarController

static void * XXContext = &XXContext;
static NSString* kCanGoBackKeyPath = @"canGoBack";
static NSString* kCanGoForwardKeyPath = @"canGoForward";
static NSString* kPageTitle = @"title";
static NSString* kPageURL = @"URL";

- (instancetype)initWithManagedWebView:(WKWebView*)webView;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _webView = webView;
    _pageURLChangedBlock = nil;
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
    [webView addObserver:self
              forKeyPath:kPageURL
                 options:0
                 context:XXContext];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    BOOL sanity = context == XXContext && object == [self webView];
    if (sanity && [keyPath isEqualToString:kCanGoBackKeyPath]) {
        BOOL canGoBack = [[self webView] canGoBack];
        [[self backButton] setEnabled:canGoBack];
    } else if (sanity && [keyPath isEqualToString:kCanGoForwardKeyPath]) {
        BOOL canGoForward = [[self webView] canGoForward];
        [[self forwardButton] setEnabled:canGoForward];
    } else if (sanity && [keyPath isEqualToString:kPageTitle]) {
        NSString* title = [[self webView] title];
        [[self navigationItem] setTitle:title];
    } else if (sanity && [keyPath isEqualToString:kPageURL]) {
        NewStringBlock block = [self pageURLChangedBlock];
        if (!block) { return; }
        NSString* title = [[[self webView] URL] absoluteString];
        block(title);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc;
{
    [[self webView] removeObserver:self forKeyPath:kCanGoBackKeyPath];
    [[self webView] removeObserver:self forKeyPath:kCanGoForwardKeyPath];
    [[self webView] removeObserver:self forKeyPath:kCanGoForwardKeyPath];
    [[self webView] removeObserver:self forKeyPath:kPageTitle];
    [[self webView] removeObserver:self forKeyPath:kPageURL];
}

@end
