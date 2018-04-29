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

@interface BrowserTabViewController ()

@property (nonatomic, strong, nullable) void (^completion)(UIViewController*);
@property (nonatomic, strong, nonnull) WKWebView* webView;
@property (nonatomic, strong, nonnull) NSArray<NSLayoutConstraint*>* sizeConstraints;
@property (nonatomic) CGFloat browserScale;

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
    _completion = completion;
    _webView = [[WKWebView alloc] init_DBR];
    _sizeConstraints = @[];
    _browserScale = 1;
    return self;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];

    [[self view] addSubview:[self webView]];
    [[self view] addConstraints:@[
                                  [[[self view] centerXAnchor] constraintEqualToAnchor:[[self webView] centerXAnchor]],
                                  [[[self view] centerYAnchor] constraintEqualToAnchor:[[self webView] centerYAnchor]],
                                  ]];
    [self setBrowserScale:3];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://theverge.com"]];
    [[self webView] loadRequest:request];
}

- (void)setBrowserScale:(CGFloat)newScale;
{
    _browserScale = newScale;
    NSArray<NSLayoutConstraint*>* newConstraints = @[
                             [NSLayoutConstraint constraintWithItem:[self webView]
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self view]
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:newScale
                                                           constant:0],
                             [NSLayoutConstraint constraintWithItem:[self webView]
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self view]
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:newScale
                                                           constant:0]
                                                     ];
    [[self view] removeConstraints:[self sizeConstraints]];
    [[self view] addConstraints:newConstraints];
    [self setSizeConstraints:newConstraints];
    [[self webView] setTransform:CGAffineTransformMakeScale(1/newScale, 1/newScale)];
    [self updateWebViewInsets];
}

- (void)updateWebViewInsets;
{
    CGFloat currentScale = [self browserScale];
    UIEdgeInsets safeAreaInsets = [[self view] safeAreaInsets];
    UIEdgeInsets calculatedInsets = UIEdgeInsetsMake(safeAreaInsets.top * currentScale,
                                                     0, // safeAreaInsets.left * currentScale, // prevents horizontal scrolling
                                                     safeAreaInsets.bottom * currentScale,
                                                     0); // safeAreaInsets.right * currentScale); // prevents horizontal scrolling
    [[[self webView] scrollView] setContentInset: calculatedInsets];
}

- (void)viewSafeAreaInsetsDidChange;
{
    [super viewSafeAreaInsetsDidChange];
    [self updateWebViewInsets];
}

@end
