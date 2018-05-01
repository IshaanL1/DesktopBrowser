//
//  BrowserTabViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"
#import "BrowserTabConfiguration.h"

typedef void (^BrowserTabViewControllerCompletionHandler)(UIViewController* __nonnull vc,
                                                           BrowserTabConfiguration* __nonnull config,
                                                           BrowserMenuAction* __nullable action);

@interface BrowserTabViewController : UIViewController

+ (UIViewController*)browserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                               completionHandler:(BrowserTabViewControllerCompletionHandler __nonnull)completionHandler;

@end
