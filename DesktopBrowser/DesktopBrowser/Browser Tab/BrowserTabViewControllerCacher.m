//
//  OpenTabCacher.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 03/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserTabViewControllerCacher.h"
#import "NSException+DBR.h"

@interface BrowserTabViewControllerCacher ()

@property (nonatomic, strong, nonnull) NSMutableDictionary<NSString*, UIViewController*>* cache;

@end

@implementation BrowserTabViewControllerCacher

- (instancetype)init
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _cache = [[NSMutableDictionary alloc] init];
    return self;
}

- (UIViewController* __nonnull)newOrCachedBrowserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                                          configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                                                    completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
{
    UIViewController* vc = [[self cache] objectForKey:[configuration UUIDString]];
    if (vc) { return vc; }
    vc = [BrowserTabViewController browserTabWithConfiguration:configuration
                                   configurationChangeDelegate:delegate
                                             completionHandler:completionHandler];
    [NSException throwIfNilObject:vc];
    [[self cache] setObject:vc forKey:[configuration UUIDString]];
    return vc;
}
- (void)invalidateCacheForConfiguration:(BrowserTabConfiguration* __nonnull)configuration;
{
    [[self cache] removeObjectForKey:[configuration UUIDString]];
}

@end
