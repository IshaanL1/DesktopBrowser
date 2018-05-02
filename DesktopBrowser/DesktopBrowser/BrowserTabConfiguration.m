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
@dynamic urlString;
@dynamic scale;
@dynamic javascriptEnabled;
- (instancetype)initWithURLString:(NSString*)urlString scale:(double)scale javascriptEnabled:(BOOL)jsEnabled;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _uuid = [[[NSUUID alloc] init] UUIDString];
    _urlString = urlString;
    _scale = scale;
    _javascriptEnabled = jsEnabled;
    return self;
}
- (instancetype)initWithUUIDString:(NSString*)uuidString urlString:(NSString*)urlString scale:(double)scale javascriptEnabled:(BOOL)jsEnabled;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _uuid = uuidString;
    _urlString = urlString;
    _scale = scale;
    _javascriptEnabled = jsEnabled;
    return self;
}
- (NSString *)urlString;
{
    return _urlString;
}
- (double)scale;
{
    return _scale;
}
- (BOOL)javascriptEnabled;
{
    return _javascriptEnabled;
}
- (id)copyWithZone:(NSZone *)zone;
{
    return [[BrowserTabConfiguration alloc] initWithUUIDString:[self uuid]
                                                     urlString:[self urlString]
                                                         scale:[self scale]
                                             javascriptEnabled:[self javascriptEnabled]];
}
@end

@implementation MutableBrowserTabConfiguration
@dynamic urlString;
@dynamic scale;
@dynamic javascriptEnabled;
- (void)setURLString:(NSString *)urlString;
{
    _urlString = urlString;
}
- (void)setScale:(double)scale;
{
    _scale = scale;
}
- (void)setJavascriptEnabled:(BOOL)javascriptEnabled;
{
    _javascriptEnabled = javascriptEnabled;
}
@end

@implementation BrowserTabConfiguration (Mutating)
- (id)mutableCopyWithZone:(NSZone *)zone;
{
    return [[MutableBrowserTabConfiguration alloc] initWithUUIDString:[self uuid]
                                                            urlString:[self urlString]
                                                                scale:[self scale]
                                                    javascriptEnabled:[self javascriptEnabled]];
}
@end
