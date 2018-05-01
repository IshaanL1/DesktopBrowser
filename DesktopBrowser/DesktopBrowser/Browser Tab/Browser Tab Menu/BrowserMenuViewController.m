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
#import "BrowserMenuTableViewController.h"

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate, BrowserMenuTableViewControllerDelegate>

@property (nonatomic, strong, nonnull) BrowserTabConfiguration* configuration;
@property (nonatomic, strong, nonnull) BrowserMenuViewControllerCompletionHandler completion;
@property (nonatomic, weak, nullable) BrowserMenuTableViewController* tableViewController;

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                          presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                            withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithConfiguration:configuration
                                                                           withCompletionHandler:completion];
    [menuVC setTitle:@"Menu"];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    [NSException throwIfNilObject:self];
    _completion = completion;
    _configuration = configuration;
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];

    // configure childVC
    BrowserMenuTableViewController* tableViewController = [[BrowserMenuTableViewController alloc] initWithConfiguration:[self configuration]];
    [tableViewController setDelegate:self];
    [self setTableViewController:tableViewController];
    [self addChildViewController:tableViewController];
    UIView* myview = [self view];
    UIView* subview = [tableViewController view];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [myview addSubview:subview];
    [myview addConstraints:@[
                             [[myview heightAnchor] constraintEqualToAnchor:[subview heightAnchor]],
                             [[myview widthAnchor] constraintEqualToAnchor:[subview widthAnchor]],
                             [[myview centerXAnchor] constraintEqualToAnchor:[subview centerXAnchor]],
                             [[myview centerYAnchor] constraintEqualToAnchor:[subview centerYAnchor]]
                             ]];
}

// MARK: BrowserMenuTableViewControllerDelegate

- (void)userDidChangeURLString:(NSString* __nonnull)newURLString;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionURLChange alloc] initWithURLString:newURLString];
    block(self, action);
}
- (void)userDidChangeWebViewScale:(BrowserMenuActionScaleChange*)action;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    block(self, action);
}
- (void)userDidChangeJSEnabled:(BOOL)jsEnabled;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionBoolChange alloc] initWithBool:jsEnabled];
    block(self, action);
}
- (void)userDidSelectHideTab;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionHideTab alloc] init];
    block(self, action);
}
- (void)userDidSelectCloseTab;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionCloseTab alloc] init];
    block(self, action);
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end


