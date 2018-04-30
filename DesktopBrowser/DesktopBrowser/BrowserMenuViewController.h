//
//  BrowserMenuViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
@import WebKit;

@interface BrowserMenuViewController : UITableViewController

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull))completion;

@end