//
//  WebViewScaleController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "WebViewScaleController.h"
#import "NSException+DBR.h"

@interface WebViewScaleController ()

@property (nonatomic) UIEdgeInsets latestSafeAreaInsets;
@property (nonatomic, strong, nonnull) NSArray<NSLayoutConstraint*>* sizeConstraints;

@end

@implementation WebViewScaleController

- (instancetype)initWithManagedWebView:(WKWebView*)webView;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _webView = webView;
    _sizeConstraints = @[];
    _browserScale = 2;
    _latestSafeAreaInsets = UIEdgeInsetsZero;
    return self;
}

- (void)setBrowserScale:(double)newScale;
{
    // do the work of the original setter
    _browserScale = newScale;

    // grab my dependencies and make sure they're not NIL
    UIView* parentView = [[self webView] superview];
    UIView* webView = [self webView];
    [NSException throwIfNilObject:parentView];
    [NSException throwIfNilObject:webView];

    // make new constraints
    NSArray<NSLayoutConstraint*>* newConstraints = @[
                                                     [NSLayoutConstraint constraintWithItem:webView
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:parentView
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                 multiplier:newScale
                                                                                   constant:0],
                                                     [NSLayoutConstraint constraintWithItem:webView
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:parentView
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                 multiplier:newScale
                                                                                   constant:0]
                                                     ];

    // disable the old constraints
    [parentView removeConstraints:[self sizeConstraints]];
    // enable the new constraints
    [parentView addConstraints:newConstraints];
    // save them for later
    [self setSizeConstraints:newConstraints];
    // update the transform of the webview
    [webView setTransform:CGAffineTransformMakeScale(1/newScale, 1/newScale)];
    // update the insets
    [self updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:[self latestSafeAreaInsets]];
}

- (void)viewDidLoad;
{
    [self setBrowserScale:[self browserScale]];
}

- (void)updateWebViewContentInsetsForCurrentScaleWithSafeAreaInsets:(UIEdgeInsets)safeAreaInsets;
{
    [self setLatestSafeAreaInsets:safeAreaInsets];
    double currentScale = [self browserScale];
    UIEdgeInsets calculatedInsets = UIEdgeInsetsMake(safeAreaInsets.top * currentScale,
                                                     0, // safeAreaInsets.left * currentScale, // prevents horizontal scrolling
                                                     safeAreaInsets.bottom * currentScale,
                                                     0); // safeAreaInsets.right * currentScale); // prevents horizontal scrolling
    [[[self webView] scrollView] setContentInset: calculatedInsets];
}

@end
