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

typedef void (^BrowserMenuViewControllerCompletionHandler)(UIViewController* __nonnull vc, BrowserMenuAction* __nullable action);

@interface BrowserMenuViewController : UITableViewController

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                       currentWebViewScale:(double)scale
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;

@end
