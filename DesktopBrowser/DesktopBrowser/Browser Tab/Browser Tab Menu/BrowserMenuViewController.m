//
//  BrowserMenuViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuViewController.h"
#import "NSException+DBR.h"
#import "BrowserMenuURLTableViewCell.h"
#import "BrowserMenuSectionsAndRows.h"
#import "UITableViewCell+DBR.h"
#import "BrowserMenuScaleTableViewCell.h"
#import "BrowserMenuJavascriptTableViewCell.h"
#import "ButtonTableViewCell.h"

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak, nullable) WKWebView* webView;
@property (nonatomic, strong, nullable) void (^completion)(UIViewController* __nonnull, BrowserMenuAction* __nonnull);
@property (nonatomic) double currentWebViewScale;

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                       currentWebViewScale:(double)scale
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nullable))completion;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithWebView:webView
                                                                       currentWebViewScale:scale
                                                                     withCompletionHandler:completion];
    [menuVC setTitle:@"Menu"];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithWebView:(WKWebView*)webView
            currentWebViewScale:(double)scale
          withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nonnull))completion;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    [NSException throwIfNilObject:self];
    _webView = webView;
    _completion = completion;
    _currentWebViewScale = scale;
    return self;
}

// MARK: Lifecycle Methods

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
    UITableViewCell* cell = nil;
    switch (indexPath.section) {
        case BrowserMenuSectionURL:
            switch (indexPath.row) {
                case BrowserMenuSectionURLRowURL:
                    cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuURLTableViewCell reuseIdentifier] forIndexPath:indexPath];
                    break;
            }
            break;
        case BrowserMenuSectionScaleJS:
            switch (indexPath.row) {
                case BrowserMenuSectionScaleJSRowScale:
                    cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuScaleTableViewCell reuseIdentifier] forIndexPath:indexPath];
                    break;
                case BrowserMenuSectionScaleJSRowJavascript:
                    cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuJavascriptTableViewCell reuseIdentifier] forIndexPath:indexPath];
                    break;
            }
            break;
        case BrowserMenuSectionHideClose:
            switch (indexPath.row) {
                case BrowserMenuSectionHideCloseRowHide:
                    cell = [tableView dequeueReusableCellWithIdentifier:[ButtonTableViewCell reuseIdentifier] forIndexPath:indexPath];
                    [(ButtonTableViewCell*)cell setDestructive:NO];
                    [(ButtonTableViewCell*)cell setButtonTitle:@"View All Tabs"];
                    break;
                case BrowserMenuSectionHideCloseRowClose:
                    cell = [tableView dequeueReusableCellWithIdentifier:[ButtonTableViewCell reuseIdentifier] forIndexPath:indexPath];
                    [(ButtonTableViewCell*)cell setDestructive:YES];
                    [(ButtonTableViewCell*)cell setButtonTitle:@"Close This Tab"];
                    break;
            }
            break;
        default:
            break;
    }
    [NSException throwIfNilObject:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    __weak BrowserMenuViewController *welf = self;
    if ([_cell isKindOfClass:[BrowserMenuURLTableViewCell class]]) {
        BrowserMenuURLTableViewCell* cell = (BrowserMenuURLTableViewCell*)_cell;
        [cell setURLString:[[[self webView] URL] absoluteString]];
        [cell setUrlConfirmedBlock:^(NSString* newURLString) {
            void (^block)(UIViewController* __nonnull, BrowserMenuAction* __nullable) = [welf completion];
            if (!block) { return; }
            BrowserMenuActionURLChange* action = [[BrowserMenuActionURLChange alloc] initWithURLString:newURLString];
            block(welf, action);
        }];
    } else if ([_cell isKindOfClass:[BrowserMenuScaleTableViewCell class]]) {
        BrowserMenuScaleTableViewCell* cell = (BrowserMenuScaleTableViewCell*)_cell;
        [cell setScale:[self currentWebViewScale]];
        [cell setScaleChangedBlock:^(BrowserMenuActionScaleChange* _Nonnull action) {
            void (^block)(UIViewController* __nonnull, BrowserMenuAction* __nullable) = [welf completion];
            if (!block) { return; }
            [welf setCurrentWebViewScale:[action scale]];
            block(welf, action);
        }];
    } else if ([_cell isKindOfClass:[BrowserMenuJavascriptTableViewCell class]]) {
        BrowserMenuJavascriptTableViewCell* cell = (BrowserMenuJavascriptTableViewCell*)_cell;
        BOOL jsEnabled = [[[[self webView] configuration] preferences] javaScriptEnabled];
        [cell setJavascriptAction:[[BrowserMenuActionBoolChange alloc] initWithBool:jsEnabled]];
        [cell setValueChangedBlock:^(BrowserMenuActionBoolChange * _Nonnull action) {
            void (^block)(UIViewController* __nonnull, BrowserMenuAction* __nullable) = [welf completion];
            if (!block) { return; }
            block(welf, action);
        }];
    } else if ([_cell isKindOfClass:[ButtonTableViewCell class]]) {
        ButtonTableViewCell* cell = (ButtonTableViewCell*)_cell;
        [cell setActionBlock:^(BOOL destructive) {
            void (^block)(UIViewController* __nonnull, BrowserMenuAction* __nullable) = [welf completion];
            if (!block) { return; }
            BrowserMenuAction* action = destructive ? [[BrowserMenuActionCloseTab alloc] init] : [[BrowserMenuActionHideTab alloc] init];
            block(welf, action);
        }];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // don't allow certain cells to be selected
    UITableViewCell* _cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!_cell) {
        return nil;
    } else if ([_cell isKindOfClass:[BrowserMenuURLTableViewCell class]]) {
        return nil;
    } else if ([_cell isKindOfClass:[BrowserMenuScaleTableViewCell class]]) {
        return nil;
    } else if ([_cell isKindOfClass:[BrowserMenuJavascriptTableViewCell class]]) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_cell isKindOfClass:[BrowserMenuURLTableViewCell class]]) {
        BrowserMenuURLTableViewCell* cell = (BrowserMenuURLTableViewCell*)_cell;
        [cell setUrlConfirmedBlock:nil];
    } else if ([_cell isKindOfClass:[BrowserMenuScaleTableViewCell class]]) {
        BrowserMenuScaleTableViewCell* cell = (BrowserMenuScaleTableViewCell*)_cell;
        [cell setScaleChangedBlock:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return browserMenuSectionTitleForSection(section);
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end


