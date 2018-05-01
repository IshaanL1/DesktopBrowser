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

@interface BrowserTabViewController : UIViewController

+ (UIViewController*)browserTabWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                               completionHandler:(void (^__nullable)(UIViewController* __nonnull,
                                                                     BrowserTabConfiguration* __nonnull,
                                                                     BrowserMenuAction* __nullable))completionHandler;

@end
