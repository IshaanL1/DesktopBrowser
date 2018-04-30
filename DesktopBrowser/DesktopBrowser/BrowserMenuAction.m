//
//  BrowserMenuAction.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuAction.h"
#import "NSException+DBR.h"

@implementation BrowserMenuAction
@end

@implementation BrowserMenuActionURLChange
- (instancetype)initWithURLString:(NSString*)url;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _urlString = url;
    return self;
}
@end

@implementation BrowserMenuActionScaleChange
- (instancetype)initWithScaleNumber:(NSNumber*)scale;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _scaleNumber = scale;
    return self;
}
@end

@implementation BrowserMenuActionCloseTab
@end

@implementation BrowserMenuActionHideTab
@end
