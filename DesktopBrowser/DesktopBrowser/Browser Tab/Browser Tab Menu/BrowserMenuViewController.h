//
//  BrowserMenuViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserTabConfiguration.h"

@protocol BrowserMenuViewControllerDelegate

- (void)userDidChangeURLString:(NSString* __nonnull)newURLString fromViewController:(UIViewController*)vc;
- (void)userDidChangeWebViewScale:(double)newScale fromViewController:(UIViewController*)vc;
- (void)userDidChangeJSEnabled:(BOOL)newJSEnabled fromViewController:(UIViewController*)vc;
- (void)userDidSelectHideTabFromViewController:(UIViewController*)vc;
- (void)userDidSelectCloseTabFromViewController:(UIViewController*)vc;
- (void)userDidRequestCloseMenuFromViewController:(UIViewController*)vc;

@end

@interface BrowserMenuViewController : UITableViewController

+ (UIViewController*)browserMenuWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                                         delegate:(id<BrowserMenuViewControllerDelegate> __nonnull)delegate
                          presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi;

@end
