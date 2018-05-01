//
//  TabListTableViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserTabConfiguration.h"

@interface TabListTableViewController : UITableViewController

@property (nonatomic, weak, nullable) NSMutableArray<BrowserTabConfiguration*>* sharedMutableDataSource;
- (void)dataChanged;

@end
