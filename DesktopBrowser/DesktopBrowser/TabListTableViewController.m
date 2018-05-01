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
}

- (void)dataChanged;
{
    [[self tableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[self sharedMutableDataSource] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TabListTabTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[TabListTabTableViewCell reuseIdentifier] forIndexPath:indexPath];
    BrowserTabConfiguration* tabData = [[self sharedMutableDataSource] objectAtIndex:indexPath.row];
    [cell setLabelTitle:[tabData currentURLString]];
    return cell;
}

@end
