//
//  TabListTableViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserTabConfiguration.h"


@protocol TabListTableViewControllerDelegate

- (void)userSelectedTabConfiguration:(BrowserTabConfiguration* __nonnull)configuration;
- (void)userDeletedTabConfigurationAtIndexPath:(NSIndexPath* __nonnull)indexPath
                         withCompletionHandler:(void (^_Nullable)(BOOL)) completion;

@end

@interface TabListTableViewController : UITableViewController

@property (nonatomic, weak, nullable) NSArray<BrowserTabConfiguration*>* dataSource;
@property (nonatomic, weak, nullable) id<TabListTableViewControllerDelegate> delegate;
- (void)addedItemAtIndex:(NSInteger)index;
- (void)reloadItemAtIndex:(NSInteger)index;
- (void)removedItemAtIndex:(NSInteger)index;

@end
