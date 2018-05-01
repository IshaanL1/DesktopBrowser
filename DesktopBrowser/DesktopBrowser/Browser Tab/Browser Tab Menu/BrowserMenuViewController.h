//
//  BrowserMenuViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
@import WebKit;
#import "BrowserMenuAction.h"

@interface BrowserMenuViewController : UITableViewController

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                       currentWebViewScale:(double)scale
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nullable))completion;

@end
