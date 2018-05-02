//
//  BrowserMenuTableViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuViewController.h"
#import "BrowserTabConfiguration.h"
@import UIKit;

@interface BrowserMenuTableViewController : UITableViewController

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                             delegate:(id<BrowserMenuViewControllerDelegate> __nonnull)delegate;


@end
