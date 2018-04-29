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
    return self;
}

@end
