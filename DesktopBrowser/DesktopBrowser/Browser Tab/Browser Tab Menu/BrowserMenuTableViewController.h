//
//  BrowserMenuTableViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuAction.h"
#import "BrowserTabConfiguration.h"
@import UIKit;

@protocol BrowserMenuTableViewControllerDelegate

- (void)userDidChangeURLString:(NSString* __nonnull)newURLString;
- (void)userDidChangeWebViewScale:(BrowserMenuActionScaleChange*)action;
- (void)userDidChangeJSEnabled:(BOOL)jsEnabled;
- (void)userDidSelectHideTab;
- (void)userDidSelectCloseTab;

@end

@interface BrowserMenuTableViewController : UITableViewController

@property (nonatomic, weak, nullable) id<BrowserMenuTableViewControllerDelegate> delegate;
- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration;


@end
