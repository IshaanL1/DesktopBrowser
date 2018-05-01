//
//  WKWebView+DBR.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "WKWebView+DBR.h"
#import "NSException+DBR.h"

@implementation WKWebView (DBR)

- (instancetype)init_DBR;
{
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc] init];
    self = [self initWithFrame:CGRectZero configuration:config];
    [NSException throwIfNilObject:self];
    [self setCustomUserAgent:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/604.1.28 (KHTML, like Gecko) Version/11.0 Safari/604.1.28"];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self scrollView] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    return self;
}

@end
