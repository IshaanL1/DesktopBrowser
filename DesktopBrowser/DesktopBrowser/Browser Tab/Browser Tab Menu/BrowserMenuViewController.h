//
//  BrowserMenuViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"
#import "BrowserTabConfiguration.h"

typedef void (^BrowserMenuViewControllerCompletionHandler)(UIViewController* __nonnull vc, BrowserMenuAction* __nullable action);

@interface BrowserMenuViewController : UITableViewController

+ (UIViewController*)browserMenuWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;

@end
