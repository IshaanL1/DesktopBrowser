//
//  BrowserTabConfiguration.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserTabConfiguration.h"
#import "NSException+DBR.h"

@implementation BrowserTabConfiguration

- (instancetype)initWithURLString:(NSString*)urlString scale:(double)scale javascriptEnabled:(BOOL)jsEnabled;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _uuid = [[[NSUUID alloc] init] UUIDString];
    _currentURLString = urlString;
    _scale = scale;
    _javascriptEnabled = jsEnabled;
    return self;
}

@end
