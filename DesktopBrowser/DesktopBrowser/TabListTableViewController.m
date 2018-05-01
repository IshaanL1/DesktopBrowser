//
//  TabListTableViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "TabListTableViewController.h"

@interface TabListTableViewController ()

@end

@implementation TabListTableViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
}

- (void)dataChanged;
{
    [[self tableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[self sharedMutableDataSource] count];
}

@end
