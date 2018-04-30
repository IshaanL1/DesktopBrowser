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

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak, nullable) WKWebView* webView;
@property (nonatomic, strong, nullable) void (^completion)(UIViewController* __nonnull, BrowserMenuAction* __nonnull);

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuForWebView:(WKWebView* __nonnull)webView
                   presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                     withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nonnull))completion;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithWebView:webView withCompletionHandler:completion];
    [menuVC setTitle:@"Menu"];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithWebView:(WKWebView*)webView
          withCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nonnull))completion;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    [NSException throwIfNilObject:self];
    _webView = webView;
    _completion = completion;
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [[self tableView] registerNib:[BrowserMenuURLTableViewCell nib] forCellReuseIdentifier:[BrowserMenuURLTableViewCell reuseIdentifier]];
    [[self tableView] setEstimatedRowHeight:100];
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[BrowserMenuURLTableViewCell reuseIdentifier] forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_cell isKindOfClass:[BrowserMenuURLTableViewCell class]]) {
        BrowserMenuURLTableViewCell* cell = (BrowserMenuURLTableViewCell*)_cell;
        [cell setURLString:[[[self webView] URL] absoluteString]];
        [cell setUrlConfirmedBlock:^(NSString* newURLString) {
            NSLog(@"Time to browse to: %@", newURLString);
        }];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_cell isKindOfClass:[BrowserMenuURLTableViewCell class]]) {
        BrowserMenuURLTableViewCell* cell = (BrowserMenuURLTableViewCell*)_cell;
        [cell setUrlConfirmedBlock:nil];
    }
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end


