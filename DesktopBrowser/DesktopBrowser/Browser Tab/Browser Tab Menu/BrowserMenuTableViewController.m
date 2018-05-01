//
//  BrowserMenuTableViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuTableViewController.h"
#import "BrowserMenuURLTableViewCell.h"
#import "BrowserMenuSectionsAndRows.h"
#import "UITableViewCell+DBR.h"
#import "BrowserMenuScaleTableViewCell.h"
#import "BrowserMenuJavascriptTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "NSException+DBR.h"
#import "BrowserMenuAction.h"

@interface BrowserMenuTableViewController ()

@property (strong, nonatomic, nonnull) BrowserTabConfiguration* configuration;

@end

@implementation BrowserMenuTableViewController

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _configuration = configuration;
    return self;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [[self tableView] registerNib:[BrowserMenuURLTableViewCell nib] forCellReuseIdentifier:[BrowserMenuURLTableViewCell reuseIdentifier]];
    [[self tableView] registerNib:[BrowserMenuScaleTableViewCell nib] forCellReuseIdentifier:[BrowserMenuScaleTableViewCell reuseIdentifier]];
    [[self tableView] registerNib:[BrowserMenuJavascriptTableViewCell nib] forCellReuseIdentifier:[BrowserMenuJavascriptTableViewCell reuseIdentifier]];
    [[self tableView] registerNib:[ButtonTableViewCell nib] forCellReuseIdentifier:[ButtonTableViewCell reuseIdentifier]];
    [[self tableView] setEstimatedRowHeight:100];
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return BrowserMenuSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return browserMenuSectionRowCountForSection(section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    __weak BrowserMenuTableViewController* welf = self;
    if (sec == BrowserMenuSectionURL && row == BrowserMenuSectionURLRowURL) {
        BrowserMenuURLTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuURLTableViewCell reuseIdentifier] forIndexPath:indexPath];;
        [cell setURLString:[[self configuration] currentURLString]];
        [cell setUrlConfirmBlock:^(NSString* newURLString) {
            [[welf delegate] userDidChangeURLString:newURLString];
        }];
        return cell;
    } else if (sec == BrowserMenuSectionScaleJS && row == BrowserMenuSectionScaleJSRowScale) {
        BrowserMenuScaleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuScaleTableViewCell reuseIdentifier] forIndexPath:indexPath];
        [cell setScale:[[self configuration] scale]];
        [cell setVerifyScale:[BrowserMenuActionScaleChange verifyScale]];
        [cell setScaleChangedBlock:^(double newScale) {
            [[welf delegate] userDidChangeWebViewScale:newScale];
        }];
        return cell;
    } else if (sec == BrowserMenuSectionScaleJS && row == BrowserMenuSectionScaleJSRowJavascript) {
        BrowserMenuJavascriptTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuJavascriptTableViewCell reuseIdentifier] forIndexPath:indexPath];
        [cell setToggleEnabled:[[self configuration] javascriptEnabled]];
        [cell setValueChangedBlock:^(BOOL jsEnabled) {
            [[welf delegate] userDidChangeJSEnabled:jsEnabled];
        }];
        return cell;
    } else if (sec == BrowserMenuSectionHideClose && row == BrowserMenuSectionHideCloseRowHide) {
        ButtonTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[ButtonTableViewCell reuseIdentifier] forIndexPath:indexPath];
        [cell setDestructive:NO];
        [cell setButtonTitle:@"View All Tabs"];
        [cell setActionBlock:^(BOOL isDestructive) {
            [[welf delegate] userDidSelectHideTab];
        }];
        return cell;
    } else if (sec == BrowserMenuSectionHideClose && row == BrowserMenuSectionHideCloseRowClose) {
        ButtonTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[ButtonTableViewCell reuseIdentifier] forIndexPath:indexPath];
        [cell setDestructive:YES];
        [cell setButtonTitle:@"Close This Tab"];
        [cell setActionBlock:^(BOOL isDestructive) {
            [[welf delegate] userDidSelectCloseTab];
        }];
        return cell;
    }
    [NSException throwIfNilObject: nil];
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (sec == BrowserMenuSectionHideClose && row == BrowserMenuSectionHideCloseRowHide) {
        return indexPath;
    } else if (sec == BrowserMenuSectionHideClose && row == BrowserMenuSectionHideCloseRowClose) {
        return indexPath;
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return browserMenuSectionTitleForSection(section);
}

@end
