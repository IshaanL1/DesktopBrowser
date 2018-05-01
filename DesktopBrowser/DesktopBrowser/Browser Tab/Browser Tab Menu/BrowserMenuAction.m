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
/// this method is smart enough to know whether the passed in value is valid
/// initializer returns NIL if the value is invalid
- (instancetype)initWithScale:(double)scale;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    if (scale < 1 || scale > 4) {
        return nil;
    }
    _scale = scale;
    return self;
}
@end

@implementation BrowserMenuActionBoolChange
- (instancetype)initWithBool:(BOOL)boolValue;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _boolValue = boolValue;
    return self;
}
@end

@implementation BrowserMenuActionCloseTab
@end

@implementation BrowserMenuActionHideTab
@end
