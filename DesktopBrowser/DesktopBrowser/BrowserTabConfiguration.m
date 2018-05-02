//
//  BrowserTabConfiguration.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserTabConfiguration.h"
#import "NSException+DBR.h"

// MARK: Immutable Implementation
@implementation BrowserTabConfiguration

// MARK: IVARS
NSString* _URLString;
NSString* _pageTitle;
double _scale;
BOOL _javascriptEnabled;

// Dynamic so I manage the getters and setters myself for Mutable subclass
@dynamic URLString;
@dynamic pageTitle;
@dynamic scale;
@dynamic javascriptEnabled;

// MARK INIT
- (instancetype)initWithURLString:(NSString*)URLString
                        pageTitle:(NSString*)pageTitle
                            scale:(double)scale
                javascriptEnabled:(BOOL)jsEnabled;
{
    self = [self initWithUUIDString:[[NSUUID UUID] UUIDString]
                          URLString:URLString
                          pageTitle:pageTitle
                              scale:scale
                  javascriptEnabled:_javascriptEnabled];
    return self;
}
- (instancetype)initWithUUIDString:(NSString*)UUIDString
                         URLString:(NSString*)URLString
                         pageTitle:(NSString*)pageTitle
                             scale:(double)scale
                 javascriptEnabled:(BOOL)jsEnabled;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _UUIDString = UUIDString;
    _URLString = URLString;
    _pageTitle = pageTitle;
    _scale = scale;
    _javascriptEnabled = jsEnabled;
    return self;
}

// MARK: Garbage Getters
- (NSString *)URLString;
{
    return _URLString;
}
- (double)scale;
{
    return _scale;
}
- (BOOL)javascriptEnabled;
{
    return _javascriptEnabled;
}

// MARK: Is Equal Conformance
- (BOOL)isEqual:(id)object;
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [[(BrowserTabConfiguration*)object UUIDString] isEqualToString:[self UUIDString]];
}

// MARK: Copyable Conformance
- (id)copyWithZone:(NSZone *)zone;
{
    return [[BrowserTabConfiguration alloc] initWithUUIDString:[self UUIDString]
                                                     URLString:[self URLString]
                                                     pageTitle:[self pageTitle]
                                                         scale:[self scale]
                                             javascriptEnabled:[self javascriptEnabled]];
}
@end

// MARK: Mutable Implementation
@implementation MutableBrowserTabConfiguration

// Dynamic so I manage the getters and setters myself for Mutable subclass
@dynamic URLString;
@dynamic pageTitle;
@dynamic scale;
@dynamic javascriptEnabled;

// MARK: Garbage Setters
- (void)setURLString:(NSString *)urlString;
{
    _URLString = urlString;
}
- (void)setPageTitle:(NSString *)pageTitle;
{
    _pageTitle = pageTitle;
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

// MARK: Mutable Copyable Conformance
@implementation BrowserTabConfiguration (Mutating)
- (id)mutableCopyWithZone:(NSZone *)zone;
{
    return [[MutableBrowserTabConfiguration alloc] initWithUUIDString:[self UUIDString]
                                                            URLString:[self URLString]
                                                            pageTitle:[self pageTitle]
                                                                scale:[self scale]
                                                    javascriptEnabled:[self javascriptEnabled]];
}
@end
