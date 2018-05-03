//
//  OpenTabCacher.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 03/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserTabConfiguration.h"
#import "BrowserTabViewController.h"

@interface OpenTabCacher : NSObject

- (UIViewController* __nonnull)newOrCachedBrowserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                     configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                               completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;
- (void)invalidateCacheForConfiguration:(BrowserTabConfiguration* __nonnull)configuration;

@end
