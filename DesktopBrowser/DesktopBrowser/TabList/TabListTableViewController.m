//
//  TabListTableViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "TabListTableViewController.h"
#import "TabListTabTableViewCell.h"
#import "UITableViewCell+DBR.h"

@interface TabListTableViewController ()

@end

@implementation TabListTableViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [[self tableView] registerNib:[TabListTabTableViewCell nib] forCellReuseIdentifier:[TabListTabTableViewCell reuseIdentifier]];
    [[self tableView] setEstimatedRowHeight:44];
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
    [[self tableView] setTableFooterView:[[UIView alloc] init]];
}

- (void)addedItemAtIndex:(NSInteger)index;
{
    [[self tableView] beginUpdates];
    [[self tableView] insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    [[self tableView] endUpdates];
}

- (void)removedItemAtIndex:(NSInteger)index;
{
    [[self tableView] beginUpdates];
    [[self tableView] deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [[self tableView] endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[self dataSource] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TabListTabTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[TabListTabTableViewCell reuseIdentifier] forIndexPath:indexPath];
    BrowserTabConfiguration* tabData = [[self dataSource] objectAtIndex:indexPath.row];
    [cell setLabelTitle:[tabData currentURLString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BrowserTabConfiguration* tabData = [[self dataSource] objectAtIndex:indexPath.row];
    [[self delegate] userSelectedTabConfiguration:tabData];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIContextualAction* action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                         title:@"Close Tab"
                                                                       handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL))
    {
        [[self delegate] userDeletedTabConfigurationAtIndexPath:indexPath withCompletionHandler:completionHandler];
    }];
    UISwipeActionsConfiguration* config = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    [config setPerformsFirstActionWithFullSwipe:YES];
    return config;
}

@end
